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

class TeacherSelected extends ObservationEvent {
  TeacherSelected({required this.teacher});
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
