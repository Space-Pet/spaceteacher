import 'dart:io';

import 'package:core/core.dart';
import 'package:meta/meta.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'register_notebook_event.dart';
part 'register_notebook_state.dart';

class RegisterNotebookBloc
    extends Bloc<RegisterNotebookEvent, RegisterNotebookState> {
  RegisterNotebookBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(RegisterNotebookState(
          listViolation: ListViolation.fakeData(),
          classCn: [],
          lessonData: [],
          datePicked: DateTime.now(),
        )) {
    on<RegisterNotebookFetchData>(_onFetchWeeklyData);
    on<RegisterSelectDate>(_onSelectDate);
    add(RegisterNotebookFetchData());
    on<GetViolationData>(_onGetViolation);
    on<GetListViolation>(_onGetListViolation);
    on<PostRegister>(_onPostRegister);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onPostRegister(
    PostRegister event,
    Emitter<RegisterNotebookState> emit,
  ) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loadingPostRegister));
    final data = await appFetchApiRepo.postRegisterBook(
      lessionId: event.lessionId,
      lessionTitle: event.lessionTitle,
      lessionNote: event.lessionNote,
      tietPpct: event.tietPpct,
      lessionRank: event.lessionRank,
      danDoBaoBai: event.danDoBaoBai,
      fileBaoBai: event.fileBaoBai,
      linkBaoBai: event.linkBaoBai,
      hanNop: event.hanNop,
      userKey: event.userKey,
    );
    emit(state.copyWith(status: RegisterNotebookStatus.successPostRegister));
  }

  _onGetListViolation(
    GetListViolation event,
    Emitter<RegisterNotebookState> emit,
  ) async {
    emit(
        state.copyWith(status: RegisterNotebookStatus.loadingGetListViolation));
    final data = await appFetchApiRepo.getListViolation();
    emit(state.copyWith(
      status: RegisterNotebookStatus.successGetListViolation,
      listViolation: data,
    ));
  }

  _onGetViolation(
    GetViolationData event,
    Emitter<RegisterNotebookState> emit,
  ) async {
    emit(
        state.copyWith(status: RegisterNotebookStatus.loadingGetViolationData));
    final data = await appFetchApiRepo.getViolationData(
      userKey: event.userKey,
      classId: event.classId,
    );
    emit(state.copyWith(
      status: RegisterNotebookStatus.successGetViolationData,
      violationData: data,
    ));
  }

  _onSelectDate(
      RegisterSelectDate event, Emitter<RegisterNotebookState> emit) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loading));
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      classSelect: event.classSelect,
      userKey: currentUserBloc.state.user.user_key,
      txtDate: event.datePicked.ddMMyyyyDash,
    );
    emit(
      state.copyWith(
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? []
            : weeklyLessonData.lessonDataList,
        datePicked: event.datePicked,
        status: RegisterNotebookStatus.success,
        classCn: event.classSelect == 1 ? weeklyLessonData.classCn : [],
      ),
    );
  }

  _onFetchWeeklyData(RegisterNotebookFetchData event,
      Emitter<RegisterNotebookState> emit) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loading));
    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      classSelect: 1,
      userKey: currentUserBloc.state.user.user_key,
      txtDate: DateTime.now().ddMMyyyyDash,
    );
    emit(
      state.copyWith(
          status: RegisterNotebookStatus.success,
          classCn: weeklyLessonData.classCn,
          lessonData: weeklyLessonData.lessonDataList.isEmpty
              ? []
              : weeklyLessonData.lessonDataList),
    );
  }
}
