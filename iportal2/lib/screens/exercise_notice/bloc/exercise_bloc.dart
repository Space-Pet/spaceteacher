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
            exerciseDataList: ExerciseData.empty(),
          ),
        ) {
    on<ExerciseFetchData>(_onFetchDueDateExercises);
    add(ExerciseFetchData());

    on<ExerciseSelectDate>(_onSelectDate);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final String todayString;

  _onFetchDueDateExercises(
      ExerciseFetchData event, Emitter<ExerciseState> emit) async {
    final exerciseDataList = await appFetchApiRepo.getExercises(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      // userKey: '0563230098',
    );

    emit(
      state.copyWith(
        subjectList: exerciseDataList.getSubjectList(),
        exerciseDataList: exerciseDataList,
      ),
    );
  }

  _onSelectDate(ExerciseSelectDate event, Emitter<ExerciseState> emit) async {
    final exerciseDataList = await appFetchApiRepo.getExercises(
      // userKey: '0563230098',
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
    );

    emit(
      state.copyWith(
        subjectList: exerciseDataList.getSubjectList(),
        exerciseDataList: exerciseDataList,
      ),
    );
  }
}
