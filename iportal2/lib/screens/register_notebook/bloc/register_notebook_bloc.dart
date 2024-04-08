import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:meta/meta.dart';
import 'package:network_data_source/network_data_source.dart';
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
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(event.datePicked),
    );
    emit(
      state.copyWith(
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? LessonData.empty()
            : weeklyLessonData.lessonDataList[0],
        datePicked: event.datePicked,
      ),
    );
  }

  _onFetchWeeklyData(RegisterNotebookFetchData event,
      Emitter<RegisterNotebookState> emit) async {
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateFormat('dd-MM-yyyy').format(DateTime.now()),
    );
    emit(state.copyWith(
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? LessonData.empty()
            : weeklyLessonData.lessonDataList[0]));
  }
}
