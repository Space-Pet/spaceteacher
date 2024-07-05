part of 'exercise_bloc.dart';

sealed class ExerciseEvent {}

class ExerciseFetchData extends ExerciseEvent {
  ExerciseFetchData();
}

class ExerciseSelectDate extends ExerciseEvent {
  ExerciseSelectDate({required this.datePicked});

  final DateTime datePicked;
}

class ExerciseChangeClassType extends ExerciseEvent {
  ExerciseChangeClassType({required this.classTypeName});
  final String classTypeName;
}
