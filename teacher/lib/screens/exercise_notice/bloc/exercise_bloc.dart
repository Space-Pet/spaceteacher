import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';
import 'package:teacher/screens/schedule/bloc/schedule_bloc.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(
          ExerciseState(
            lessonData: LessonData.fakeDataList(),
            datePicked: DateTime.now(),
          ),
        ) {
    on<ExerciseFetchData>(_onFetchWeeklyData);
    add(ExerciseFetchData());

    on<ExerciseSelectDate>(_onSelectDate);
    on<ExerciseChangeClassType>(_onChangeClassType);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onFetchWeeklyData(
      ExerciseFetchData event, Emitter<ExerciseState> emit) async {
    emit(state.copyWith(status: ExerciseStatus.loading));

    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      classSelect: state.classType.value,
      userKey: currentUserBloc.state.user.user_key,
      txtDate: state.datePicked.ddMMyyyyDash,
    );

    if (weeklyLessonData.classCn != null) {
      emit(state.copyWith(classCn: weeklyLessonData.classCn!.first));
    }

    emit(
      state.copyWith(
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? []
            : weeklyLessonData.lessonDataList,
        status: ExerciseStatus.loaded,
      ),
    );
  }

  _onSelectDate(ExerciseSelectDate event, Emitter<ExerciseState> emit) async {
    emit(state.copyWith(datePicked: event.datePicked));
    add(ExerciseFetchData());
  }

  void _onChangeClassType(
      ExerciseChangeClassType event, Emitter<ExerciseState> emit) {
    final newClassType = event.classTypeName == ClassType.chuNhiem.name
        ? ClassType.chuNhiem
        : ClassType.giangDay;

    emit(state.copyWith(classType: newClassType));
    add(ExerciseFetchData());
  }
}
