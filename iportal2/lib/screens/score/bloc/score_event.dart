part of 'score_bloc.dart';

@immutable
sealed class ScoreEvent {}

class ScoreFetchData extends ScoreEvent {
  ScoreFetchData();
}

class ScoreFetchMoetType extends ScoreEvent {
  ScoreFetchMoetType();
}

class ScoreFetchMoetAverage extends ScoreEvent {
  ScoreFetchMoetAverage();
}

class ScoreFetchEsl extends ScoreEvent {
  ScoreFetchEsl();
}

class ScoreFetchPrimaryConduct extends ScoreEvent {
  ScoreFetchPrimaryConduct();
}

class ScoreFetchProgramList extends ScoreEvent {
  ScoreFetchProgramList();
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
  ScoreFilterChange(this.scoreFilter);

  final ViewScoreSelectedParam scoreFilter;

  List<Object> get props => [scoreFilter];
}
