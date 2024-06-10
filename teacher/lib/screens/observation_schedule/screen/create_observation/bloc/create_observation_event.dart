part of 'create_observation_bloc.dart';

abstract class CreateObservationEvent {}

class CreateObservationInit extends CreateObservationEvent {}

class DateChanged extends CreateObservationEvent {
  DateChanged({required this.time});
  final DateTime time;
}

class SubjectChanged extends CreateObservationEvent {
  SubjectChanged({required this.subject});
  final String subject;
}

class ClassChanged extends CreateObservationEvent {
  ClassChanged({required this.className});
  final String className;
}

class PeriodChanged extends CreateObservationEvent {
  PeriodChanged({required this.period});
  final String period;
}

class InfoChanged extends CreateObservationEvent {
  InfoChanged({required this.info});
  final String info;
}

class TeacherSelected extends CreateObservationEvent {
  TeacherSelected({required this.teacher});
  final TeacherItem teacher;
}

class TeacherRemoved extends CreateObservationEvent {
  TeacherRemoved({required this.teacher});
  final TeacherItem teacher;
}

class TeacherFetched extends CreateObservationEvent {}

class ObservationCreated extends CreateObservationEvent {}
