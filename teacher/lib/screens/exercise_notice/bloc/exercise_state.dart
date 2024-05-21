part of 'exercise_bloc.dart';

enum ExerciseStatus { initial, loading, loaded, error }

class ExerciseState extends Equatable {
  const ExerciseState({
    required this.exerciseDataList,
    required this.subjectList,
    required this.tempData,
    this.status = ExerciseStatus.initial,
    this.selectedSubject = 'Tất cả các môn',
  });

  final List<ExerciseItem> exerciseDataList;
  final List<ExerciseItem> tempData;

  final List<String> subjectList;
  final String selectedSubject;

  final ExerciseStatus status;

  @override
  List<Object?> get props =>
      [exerciseDataList, tempData, subjectList, status, selectedSubject];

  ExerciseState copyWith({
    List<ExerciseItem>? exerciseDataList,
    List<ExerciseItem>? tempData,
    List<String>? subjectList,
    String? userKey,
    String? txtDate,
    ExerciseStatus? status,
    String? selectedSubject,
  }) {
    return ExerciseState(
      exerciseDataList: exerciseDataList ?? this.exerciseDataList,
      tempData: tempData ?? this.tempData,
      subjectList: subjectList ?? this.subjectList,
      status: status ?? this.status,
      selectedSubject: selectedSubject ?? this.selectedSubject,
    );
  }
}
