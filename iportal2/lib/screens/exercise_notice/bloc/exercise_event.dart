part of 'exercise_bloc.dart';

@immutable
sealed class ExerciseEvent {}

class ExerciseFetchData extends ExerciseEvent {
  ExerciseFetchData();
}

class ExerciseSelectDate extends ExerciseEvent {
  ExerciseSelectDate({required this.datePicked});

  final DateTime datePicked;
}
