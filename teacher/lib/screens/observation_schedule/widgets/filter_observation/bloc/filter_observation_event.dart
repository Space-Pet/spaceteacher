part of 'filter_observation_bloc.dart';

abstract class FilterObservationEvent {}

class ListTeacherFetched extends FilterObservationEvent {}

class FilterSubmitted extends FilterObservationEvent {}

class DateChanged extends FilterObservationEvent {
  DateChanged(this.date);
  final String date;
}

class TeacherChanged extends FilterObservationEvent {
  TeacherChanged(this.teacher);
  final String teacher;
}
