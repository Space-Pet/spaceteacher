part of 'score_bloc.dart';

sealed class ScoreEvent {}

class ClassListFetched extends ScoreEvent {}

class ScoreFetchMoet extends ScoreEvent {
  ScoreFetchMoet();
}

class ScoreFetchEsl extends ScoreEvent {
  ScoreFetchEsl();
}

class ScoreFetchPrimaryConduct extends ScoreEvent {
  ScoreFetchPrimaryConduct();
}

class ScoreTxtTermChange extends ScoreEvent {
  ScoreTxtTermChange(this.txtHocKy);

  final String txtHocKy;

  List<Object> get props => [txtHocKy];
}

class ScoreLearnYearChange extends ScoreEvent {
  ScoreLearnYearChange(this.txtLearnYear);

  final String txtLearnYear;

  List<Object> get props => [txtLearnYear];
}

class ScoreFilterChange extends ScoreEvent {
  ScoreFilterChange(this.scoreFilter, this.isPrimary);

  final ViewScoreSelectedParam scoreFilter;
  final bool isPrimary;

  List<Object> get props => [scoreFilter];
}
