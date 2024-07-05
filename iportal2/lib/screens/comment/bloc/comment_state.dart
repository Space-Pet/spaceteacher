part of 'comment_bloc.dart';

class CommentState {
  final List<Comment>? comment;
  final CommentStatus commentStatus;
  final List<ListReportStudent> listReportStudent;
  final DateTime endDate;
  final DateTime startDate;
  final ReportStudent? reportStudent;
  final String? txtHocKy;
  final String learnYear;

  const CommentState({
    this.learnYear = '',
    required this.comment,
    String? txtHocKy,
    this.commentStatus = CommentStatus.loading,
    required this.listReportStudent,
    required this.endDate,
    this.reportStudent,
    required this.startDate,
  }) : txtHocKy = txtHocKy ?? '1';

  List<Object?> get props => [
        learnYear,
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
    String? learnYear,
    List<Comment>? comment,
    CommentStatus? commentStatus,
    List<ListReportStudent>? listReportStudent,
    ReportStudent? reportStudent,
    DateTime? endDate,
    String? txtHocKy,
    DateTime? startDate,
  }) {
    return CommentState(
      learnYear: learnYear ?? this.learnYear,
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

//////
enum TermYear {
  year1,
  year2,
  year3,
}

extension TermYearX on TermYear {
  String text() {
    int currentYear = DateTime.now().year;
    switch (this) {
      case TermYear.year1:
        return "${currentYear - 1}-${currentYear}";
      case TermYear.year2:
        return "${currentYear - 2}-${currentYear - 1}";
      case TermYear.year3:
        return "${currentYear - 3}-${currentYear - 2}";
      default:
        return "";
    }
  }

  String getValue() {
    return text();
  }
}
