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
}

class PreScoreState {
  final PreScoreStatus preScoreStatus;
  final TeacherDetail userData;
  final List<PhoneBookStudent> listStudent;
  final List<Armorial> armorial;
  final List<Comment> comment;
  final DateTime startDate;
  final DateTime endDate;
  PreScoreState({
    required this.startDate,
    required this.endDate,
    required this.armorial,
    this.listStudent = const [],
    required this.comment,
    required this.userData,
    this.preScoreStatus = PreScoreStatus.init,
  });

  List<Object?> get props => [
        preScoreStatus,
        userData,
        listStudent,
        armorial,
        comment,
        startDate,
        endDate,
      ];
  PreScoreState copyWith({
    List<PhoneBookStudent>? listStudent,
    PreScoreStatus? preScoreStatus,
    TeacherDetail? userData,
    List<Armorial>? armorial,
    List<Comment>? comment,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return PreScoreState(
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
