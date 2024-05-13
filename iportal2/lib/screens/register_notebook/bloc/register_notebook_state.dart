part of 'register_notebook_bloc.dart';

enum RegisterNotebookStatus { init, loading, success, failure }

class RegisterNotebookState extends Equatable {
  const RegisterNotebookState({
    required this.lessonData,
    required this.datePicked,
    this.status = RegisterNotebookStatus.init,
  });

  final LessonData lessonData;
  final DateTime datePicked;
  final RegisterNotebookStatus status;

  @override
  List<Object?> get props => [lessonData, datePicked, status];

  RegisterNotebookState copyWith({
    LessonData? lessonData,
    DateTime? datePicked,
    RegisterNotebookStatus? status,
  }) {
    return RegisterNotebookState(
      lessonData: lessonData ?? this.lessonData,
      datePicked: datePicked ?? this.datePicked,
      status: status ?? this.status,
    );
  }
}
