part of 'register_notebook_bloc.dart';

class RegisterNotebookState extends Equatable {
  const RegisterNotebookState({
    required this.lessonData,
    required this.datePicked,
  });

  final LessonData lessonData;
  final DateTime datePicked;

  @override
  List<Object?> get props => [lessonData, datePicked];

  RegisterNotebookState copyWith({
    LessonData? lessonData,
    DateTime? datePicked,
  }) {
    return RegisterNotebookState(
      lessonData: lessonData ?? this.lessonData,
      datePicked: datePicked ?? this.datePicked,
    );
  }
}
