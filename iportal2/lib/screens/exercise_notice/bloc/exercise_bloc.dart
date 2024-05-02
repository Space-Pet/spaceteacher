import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_data_source/network_data_source.dart';
import 'package:repository/repository.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc(
      {required this.appFetchApiRepo,
      required this.currentUserBloc,
      required this.todayString})
      : super(
          ExerciseState(
            subjectList: const [],
            tempData: ExerciseData.empty(),
            exerciseDataList: ExerciseData.empty(),
          ),
        ) {
    on<ExerciseFetchData>(_onFetchDueDateExercises);
    add(ExerciseFetchData());

    on<ExerciseSelectDate>(_onSelectDate);
    on<ExerciseSelectSubject>(_onSelectSubject);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final String todayString;

  _onFetchDueDateExercises(
      ExerciseFetchData event, Emitter<ExerciseState> emit) async {
    emit(state.copyWith(status: ExerciseStatus.loading));

    final exerciseDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      // userKey: '0723210020',
    );

    emit(
      state.copyWith(
        subjectList: exerciseDataList.exerciseDataList.isEmpty
            ? []
            : exerciseDataList.exerciseDataList
                .map((e) => e.subjectName)
                .toList(),
        exerciseDataList: exerciseDataList,
        tempData: exerciseDataList,
        status: ExerciseStatus.loaded,
      ),
    );
  }

  _onSelectDate(ExerciseSelectDate event, Emitter<ExerciseState> emit) async {
    emit(state.copyWith(status: ExerciseStatus.loading));

    final exerciseDataList = await appFetchApiRepo.getExercises(
      // userKey: '0723210020',
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
    );

    emit(
      state.copyWith(
        subjectList: exerciseDataList.exerciseDataList.isEmpty
            ? []
            : exerciseDataList.exerciseDataList
                .map((e) => e.subjectName)
                .toList(),
        exerciseDataList: exerciseDataList,
        tempData: exerciseDataList,
        selectedSubject: 'Tất cả các môn',
        status: ExerciseStatus.loaded,
      ),
    );
  }

  _onSelectSubject(ExerciseSelectSubject event, Emitter<ExerciseState> emit) {
    emit(state.copyWith(selectedSubject: event.selectedSubject));

    if (event.selectedSubject == 'Tất cả các môn') {
      emit(state.copyWith(
        tempData: state.exerciseDataList,
      ));
    } else {
      final filterData = state.exerciseDataList.exerciseDataList
          .where((element) => element.subjectName == event.selectedSubject)
          .toList();

      emit(state.copyWith(
        tempData: ExerciseData(exerciseDataList: filterData),
      ));
    }
  }
}
