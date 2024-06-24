part of 'register_notebook_bloc.dart';

enum RegisterNotebookStatus {
  init,
  loading,
  success,
  failure,

  loadingGetViolationData,
  successGetViolationData,

  loadingGetListViolation,
  successGetListViolation,

  loadingPostRegister,
  successPostRegister,
}

class RegisterNotebookState extends Equatable {
  const RegisterNotebookState({
    required this.lessonData,
    required this.datePicked,
    required this.classCn,
    this.status = RegisterNotebookStatus.init,
    this.violationData,
    required this.listViolation,
  });

  final List<LessonData> lessonData;
  final List<ClassCn> classCn;
  final DateTime datePicked;
  final RegisterNotebookStatus status;
  final ViolationData? violationData;
  final List<ListViolation> listViolation;
  @override
  List<Object?> get props => [
        lessonData,
        datePicked,
        status,
        classCn,
        violationData,
        listViolation,
      ];

  RegisterNotebookState copyWith({
    List<ListViolation>? listViolation,
    ViolationData? violationData,
    List<ClassCn>? classCn,
    List<LessonData>? lessonData,
    DateTime? datePicked,
    RegisterNotebookStatus? status,
  }) {
    return RegisterNotebookState(
      listViolation: listViolation ?? this.listViolation,
      violationData: violationData ?? this.violationData,
      classCn: classCn ?? this.classCn,
      lessonData: lessonData ?? this.lessonData,
      datePicked: datePicked ?? this.datePicked,
      status: status ?? this.status,
    );
  }
}
