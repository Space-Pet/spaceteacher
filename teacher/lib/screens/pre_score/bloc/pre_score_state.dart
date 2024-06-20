part of 'pre_score_bloc.dart';

enum PreScoreStatus {
  init,
  loadingGetListStudent,
  successGetListStudent,

  loadingGetTeacherDetail,
  successGetTeacherDetail,

  loadingGetArmorial,
  successGetArmorial,

  loadingGetComment,
  successGetComment,

  loadingPostComment,
  successPostComment,
  failPost,

  loadingGetForm,
  successGetForm,

  loadingGetListStudentReport,
  successGetListStudentReport,

  loadingGetFormDetail,
  successGetFormDetail,
}

class PreScoreState {
  final String status;
  final PreScoreStatus preScoreStatus;
  final TeacherDetail userData;
  final List<PhoneBookStudent> listStudent;
  final List<Armorial> armorial;
  final List<Comment> comment;
  final DateTime startDate;
  final DateTime endDate;
  final List<ListAllForm> listAllForm;
  final List<ListStudentFormReport> listStudentFormReport;
  final FormDetail formDetail;
  PreScoreState({
    required this.formDetail,
    required this.status,
    required this.listStudentFormReport,
    required this.startDate,
    required this.endDate,
    required this.armorial,
    this.listStudent = const [],
    required this.comment,
    required this.userData,
    this.preScoreStatus = PreScoreStatus.init,
    required this.listAllForm,
  });

  List<Object?> get props => [
        preScoreStatus,
        userData,
        listStudent,
        armorial,
        comment,
        startDate,
        endDate,
        status,
        listAllForm,
        listStudentFormReport,
        formDetail,
      ];
  PreScoreState copyWith({
    List<ListStudentFormReport>? listStudentFormReport,
    String? status,
    List<PhoneBookStudent>? listStudent,
    PreScoreStatus? preScoreStatus,
    TeacherDetail? userData,
    List<Armorial>? armorial,
    List<Comment>? comment,
    DateTime? startDate,
    DateTime? endDate,
    List<ListAllForm>? listAllForm,
    FormDetail? formDetail,
  }) {
    return PreScoreState(
      formDetail: formDetail ?? this.formDetail,
      listStudentFormReport:
          listStudentFormReport ?? this.listStudentFormReport,
      listAllForm: listAllForm ?? this.listAllForm,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      comment: comment ?? this.comment,
      armorial: armorial ?? this.armorial,
      listStudent: listStudent ?? this.listStudent,
      userData: userData ?? this.userData,
      preScoreStatus: preScoreStatus ?? this.preScoreStatus,
    );
  }
}
