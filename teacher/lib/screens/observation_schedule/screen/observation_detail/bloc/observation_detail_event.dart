part of 'observation_detail_bloc.dart';

abstract class ObservationDetailEvent {}

class ObservationDetailInit extends ObservationDetailEvent {}

class LessonRegisterPosted extends ObservationDetailEvent {
  LessonRegisterPosted({
    required this.data,
  });
  final ObservationData data;
}
