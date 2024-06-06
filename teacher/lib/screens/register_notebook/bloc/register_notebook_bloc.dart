import 'package:core/core.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'register_notebook_event.dart';
part 'register_notebook_state.dart';

class RegisterNotebookBloc
    extends Bloc<RegisterNotebookEvent, RegisterNotebookState> {
  RegisterNotebookBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(RegisterNotebookState(
          lessonData: LessonData.empty(),
          datePicked: DateTime.now(),
        )) {
    on<RegisterNotebookFetchData>(_onFetchWeeklyData);
    on<RegisterSelectDate>(_onSelectDate);
    add(RegisterNotebookFetchData());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onSelectDate(
      RegisterSelectDate event, Emitter<RegisterNotebookState> emit) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loading));
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: event.datePicked.ddMMyyyyDash,
    );
    emit(
      state.copyWith(
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? LessonData.empty()
            : weeklyLessonData.lessonDataList[0],
        datePicked: event.datePicked,
        status: RegisterNotebookStatus.success,
      ),
    );
  }

  _onFetchWeeklyData(RegisterNotebookFetchData event,
      Emitter<RegisterNotebookState> emit) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loading));
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateTime.now().ddMMyyyyDash,
    );
    emit(
      state.copyWith(
          status: RegisterNotebookStatus.success,
          lessonData: weeklyLessonData.lessonDataList.isEmpty
              ? LessonData.empty()
              : weeklyLessonData.lessonDataList[0]),
    );
  }
}
