import 'dart:io';

import 'package:core/core.dart';
import 'package:repository/repository.dart';
import 'package:teacher/common_bloc/current_user/current_user_bloc.dart';

part 'register_notebook_event.dart';
part 'register_notebook_state.dart';

class RegisterNotebookBloc
    extends Bloc<RegisterNotebookEvent, RegisterNotebookState> {
  RegisterNotebookBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(RegisterNotebookState(
          listViolation: ListViolation.fakeData(),
          lessonData: LessonData.fakeDataList(),
          classCn: const [],
          datePicked: DateTime.now(),
        )) {
    on<RegisterNotebookFetchData>(_onFetchWeeklyData);
    on<RegisterSelectDate>(_onSelectDate);
    add(RegisterNotebookFetchData());

    on<GetViolationData>(_onGetViolation);
    on<GetListViolation>(_onGetListViolation);
    on<PostRegister>(_onPostRegister);
    on<PostViolation>(_onPostViolation);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  _onPostViolation(
    PostViolation event,
    Emitter<RegisterNotebookState> emit,
  ) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loadingPostViolation));
    final data = await appFetchApiRepo.postViolation(
      containerData: event.containerData,
    );
    emit(state.copyWith(
      status: data['status'] == 'Success'
          ? RegisterNotebookStatus.successPostViolation
          : RegisterNotebookStatus.failPost,
      message: data['status_note'],
    ));
  }

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
    emit(state.copyWith(
      status: data['status'] == 'Success'
          ? RegisterNotebookStatus.successPostRegister
          : RegisterNotebookStatus.failPost,
      containerData: event.containerData,
      message: data['status_note'],
    ));
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
    emit(state.copyWith(
      datePicked: event.datePicked,
      classSelect: event.classSelect,
    ));

    add(RegisterNotebookFetchData());
  }

  _onFetchWeeklyData(RegisterNotebookFetchData event,
      Emitter<RegisterNotebookState> emit) async {
    emit(state.copyWith(status: RegisterNotebookStatus.loading));

    final weeklyLessonData = await appFetchApiRepo.getRegisterNoteBook(
      classSelect: state.classSelect,
      userKey: currentUserBloc.state.user.user_key,
      txtDate: state.datePicked.ddMMyyyyDash,
    );
    emit(
      state.copyWith(
        status: RegisterNotebookStatus.success,
        classCn: state.classSelect == 1 ? weeklyLessonData.classCn : [],
        lessonData: weeklyLessonData.lessonDataList.isEmpty
            ? []
            : weeklyLessonData.lessonDataList,
      ),
    );
  }
}
