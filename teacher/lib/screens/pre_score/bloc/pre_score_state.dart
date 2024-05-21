part of 'pre_score_bloc.dart';

enum PreScoreStatus {
  init,
  loading,
  success,
  loadingListReport,
  successListReport,
  loadingReportStudent,
  successReportStudent
}

class PreScoreState {
  final List<Comment>? comment;
  final PreScoreStatus preScoreStatus;
  final List<ListReportStudent>? listReportStudent;
  final DateTime? endDate;
  final DateTime? startDate;
  final ReportStudent? reportStudent;
  final String? txtHocKy;
  const PreScoreState(
      {required this.comment,
      String? txtHocKy,
      this.preScoreStatus = PreScoreStatus.init,
      this.listReportStudent,
      this.endDate,
      this.reportStudent,
      this.startDate})
      : txtHocKy = txtHocKy ?? '1';

  List<Object?> get props => [
        comment,
        preScoreStatus,
        endDate,
        startDate,
        listReportStudent,
        reportStudent,
        txtHocKy
      ];
  PreScoreState copyWith(
      {List<Comment>? comment,
      PreScoreStatus? preScoreStatus,
      List<ListReportStudent>? listReportStudent,
      ReportStudent? reportStudent,
      DateTime? endDate,
      String? txtHocKy,
      DateTime? startDate}) {
    return PreScoreState(
        txtHocKy: txtHocKy ?? this.txtHocKy,
        reportStudent: reportStudent ?? this.reportStudent,
        listReportStudent: listReportStudent ?? this.listReportStudent,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        comment: comment ?? this.comment,
        preScoreStatus: preScoreStatus ?? this.preScoreStatus);
  }
}
