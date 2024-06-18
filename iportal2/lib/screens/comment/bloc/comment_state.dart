part of 'comment_bloc.dart';

class CommentState {
  final List<Comment>? comment;
  final CommentStatus commentStatus;
  final List<ListReportStudent> listReportStudent;
  final DateTime? endDate;
  final DateTime? startDate;
  final ReportStudent? reportStudent;
  final String? txtHocKy;

  const CommentState({
    required this.comment,
    String? txtHocKy,
    this.commentStatus = CommentStatus.loading,
    required this.listReportStudent,
    this.endDate,
    this.reportStudent,
    this.startDate,
  }) : txtHocKy = txtHocKy ?? '1';

  List<Object?> get props => [
        comment,
        commentStatus,
        endDate,
        startDate,
        listReportStudent,
        reportStudent,
        txtHocKy
      ];

  static String _calculateYearRange() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int previousYear = currentYear - 1;
    return '$previousYear-$currentYear';
  }

  CommentState copyWith({
    List<Comment>? comment,
    CommentStatus? commentStatus,
    List<ListReportStudent>? listReportStudent,
    ReportStudent? reportStudent,
    DateTime? endDate,
    String? txtHocKy,
    DateTime? startDate,
  }) {
    return CommentState(
      txtHocKy: txtHocKy ?? this.txtHocKy,
      reportStudent: reportStudent ?? this.reportStudent,
      listReportStudent: listReportStudent ?? this.listReportStudent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      comment: comment ?? this.comment,
      commentStatus: commentStatus ?? this.commentStatus,
    );
  }
}

enum CommentStatus {
  init,
  loading,
  success,
  loadingListReport,
  successListReport,
  loadingReportStudent,
  successReportStudent,
}

enum TermType {
  term1,
  term2,
}

extension TermTypeX on TermType {
  String text() {
    int currentYear = DateTime.now().year;
    int previousYear = currentYear - 1;
    switch (this) {
      case TermType.term1:
        return "Học kỳ 1 - Năm học $previousYear-$currentYear";
      case TermType.term2:
        return "Học kỳ 2 - Năm học $previousYear-$currentYear";
      default:
        return "Cuối kỳ - Năm học $previousYear-$currentYear";
    }
  }

  String getValue() {
    switch (this) {
      case TermType.term1:
        return "1";
      case TermType.term2:
        return "2";
      default:
        return "3";
    }
  }
}
