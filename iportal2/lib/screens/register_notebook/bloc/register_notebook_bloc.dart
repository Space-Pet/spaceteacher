import 'package:bloc/bloc.dart';
import 'package:core/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'register_notebook_event.dart';
part 'register_notebook_state.dart';

class RegisterNotebookBloc
    extends Bloc<RegisterNotebookEvent, RegisterNotebookState> {
  RegisterNotebookBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
  }) : super(RegisterNotebookState(
          lessonData: LessonData.fakeData(),
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
    emit(state.copyWith(
      status: RegisterNotebookStatus.loading,
      lessonData: LessonData.fakeData(),
    ));
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      userKey: currentUserBloc.state.activeChild.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
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
      userKey: currentUserBloc.state.activeChild.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
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
