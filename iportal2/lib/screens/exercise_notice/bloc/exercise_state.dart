part of 'exercise_bloc.dart';

class ExerciseState extends Equatable {
  const ExerciseState({
    required this.exerciseDataList,
    required this.subjectList,
  });

  final ExerciseData exerciseDataList;
  final List<String> subjectList;

  @override
  List<Object?> get props => [exerciseDataList, subjectList];

  ExerciseState copyWith({
    ExerciseData? exerciseDataList,
    List<String>? subjectList,
    String? userKey,
    String? txtDate,
  }) {
    return ExerciseState(
      exerciseDataList: exerciseDataList ?? this.exerciseDataList,
      subjectList: subjectList ?? this.subjectList,
    );
  }
}
