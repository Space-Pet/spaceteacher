part of 'pre_score_bloc.dart';

abstract class PreScoreEvent extends Equatable {}

class GetComment extends PreScoreEvent {
  final String txtDate;
  late DateTime endDate = DateTime.now();
  late DateTime startDate = DateTime.now();

  GetComment(
      {required this.txtDate, required this.endDate, required this.startDate});
  @override
  List<Object> get props => [txtDate, endDate, startDate];
}

class GetListReportStudent extends PreScoreEvent {
  final String learnYear;
  GetListReportStudent({required this.learnYear});
  @override
  List<Object> get props => [learnYear];
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