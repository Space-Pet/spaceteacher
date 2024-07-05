part of 'exercise_bloc.dart';

enum ExerciseStatus { initial, loading, loaded, error }

class ExerciseState extends Equatable {
  const ExerciseState({
    required this.lessonData,
    this.classCn,
    this.status = ExerciseStatus.initial,
    this.classType = ClassType.giangDay,
    required this.datePicked,
  });

  final List<LessonData> lessonData;
  final ClassCn? classCn;
  final DateTime datePicked;

  final ClassType classType;
  final ExerciseStatus status;

  @override
  List<Object?> get props =>
      [lessonData, status, classType, datePicked, classCn];

  ExerciseState copyWith({
    List<LessonData>? lessonData,
    ClassCn? classCn,
    ExerciseStatus? status,
    ClassType? classType,
    DateTime? datePicked,
  }) {
    return ExerciseState(
      lessonData: lessonData ?? this.lessonData,
      classCn: classCn ?? this.classCn,
      status: status ?? this.status,
      classType: classType ?? this.classType,
      datePicked: datePicked ?? this.datePicked,
    );
  }
}
