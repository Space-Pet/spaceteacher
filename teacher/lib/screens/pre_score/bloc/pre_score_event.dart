part of 'pre_score_bloc.dart';

abstract class PreScoreEvent extends Equatable {}

class GetComment extends PreScoreEvent {
  final String txtDate;
  final DateTime? inputEndDate;
  final DateTime? inputStartDate;

  DateTime get endDate => inputEndDate ?? DateTime.now();
  DateTime get startDate => inputStartDate ?? DateTime.now();
  

  GetComment(
      {required this.txtDate, this.inputEndDate,  this.inputStartDate});
  @override
  List<Object> get props => [txtDate, endDate, startDate];
}

class GetListReportStudent extends PreScoreEvent {
  final String learnYear;
  final int semester;
  GetListReportStudent({required this.learnYear, required this.semester});
  @override
  List<Object> get props => [learnYear, semester];
}

class GetReportStudent extends PreScoreEvent {
  final int id;
  GetReportStudent({required this.id});
  @override
  List<Object> get props => [id];
}
class ScoreTxtTermChange extends PreScoreEvent {
  ScoreTxtTermChange(this.txtHocKy);

  final String txtHocKy;

  @override
  List<Object> get props => [txtHocKy];
}