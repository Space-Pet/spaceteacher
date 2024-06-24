part of 'observation_bloc.dart';

abstract class ObservationEvent {}

class TeacherFetched extends ObservationEvent {}

class ObservationScheduleFetched extends ObservationEvent {
  ObservationScheduleFetched();
}

class DateChanged extends ObservationEvent {
  DateChanged({required this.datePicked});
  final DateTime datePicked;
}

class SubjectChanged extends ObservationEvent {
  SubjectChanged({required this.subject});
  final String subject;
}

class ClassChanged extends ObservationEvent {
  ClassChanged({required this.className});
  final String className;
}

class PeriodChanged extends ObservationEvent {
  PeriodChanged({required this.period});
  final String period;
}

class InfoChanged extends ObservationEvent {
  InfoChanged({required this.info});
  final String info;
}

class TeacherSelected extends ObservationEvent {
  TeacherSelected({required this.teacher});
  final TeacherItem teacher;
}

class TeacherRemoved extends ObservationEvent {
  TeacherRemoved({required this.teacher});
  final TeacherItem teacher;
}

class LessonRegisterPosted extends ObservationEvent {
  LessonRegisterPosted({
    required this.data,
  });
  final ObservationData data;
}

class RegisteredDateChanged extends ObservationEvent {
  RegisteredDateChanged({required this.datePicked});
  final DateTime datePicked;
}

class RegisteredLessonFetch extends ObservationEvent {}

class DeleteLessonRegistered extends ObservationEvent {
  final String lessonRegisterId;

  DeleteLessonRegistered({required this.lessonRegisterId});
}
