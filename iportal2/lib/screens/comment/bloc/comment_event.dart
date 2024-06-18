part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {}

class GetComment extends CommentEvent {
  final String txtDate;
  final DateTime? inputEndDate;
  final DateTime? inputStartDate;

  DateTime get endDate => inputEndDate ?? DateTime.now();
  DateTime get startDate => inputStartDate ?? DateTime.now();

  GetComment({required this.txtDate, this.inputEndDate, this.inputStartDate});
  @override
  List<Object> get props => [txtDate, endDate, startDate];
}

class GetListReportStudent extends CommentEvent {
  final String learnYear;
  final int semester;

  GetListReportStudent({
    required this.learnYear,
    required this.semester,
  });

  @override
  List<Object> get props => [learnYear, semester];
}

class GetReportStudent extends CommentEvent {
  final int id;
  GetReportStudent({required this.id});
  @override
  List<Object> get props => [id];
}

class ScoreTxtTermChange extends CommentEvent {
  ScoreTxtTermChange(this.txtHocKy);

  final String txtHocKy;

  @override
  List<Object> get props => [txtHocKy];
}
