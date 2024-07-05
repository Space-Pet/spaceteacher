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

  loadingPostViolation,
  successPostViolation,

  failPost,
}

class RegisterNotebookState extends Equatable {
  const RegisterNotebookState({
    required this.lessonData,
    required this.datePicked,
    required this.classCn,
    this.status = RegisterNotebookStatus.init,
    this.violationData,
    required this.listViolation,
    this.message = '',
    this.containerData,
    this.classSelect = 2,
  });

  final List<LessonData> lessonData;
  final List<ClassCn> classCn;
  final DateTime datePicked;
  final RegisterNotebookStatus status;
  final ViolationData? violationData;
  final List<ListViolation> listViolation;
  final String message;
  final List<Map<String, dynamic>>? containerData;
  final int classSelect;
  @override
  List<Object?> get props => [
        classSelect,
        message,
        lessonData,
        datePicked,
        status,
        classCn,
        violationData,
        listViolation,
        containerData,
      ];

  RegisterNotebookState copyWith({
    int? classSelect,
    List<Map<String, dynamic>>? containerData,
    String? message,
    List<ListViolation>? listViolation,
    ViolationData? violationData,
    List<ClassCn>? classCn,
    List<LessonData>? lessonData,
    DateTime? datePicked,
    RegisterNotebookStatus? status,
  }) {
    return RegisterNotebookState(
      classSelect: classSelect ?? this.classSelect,
      containerData: containerData ?? this.containerData,
      message: message ?? this.message,
      listViolation: listViolation ?? this.listViolation,
      violationData: violationData ?? this.violationData,
      classCn: classCn ?? this.classCn,
      lessonData: lessonData ?? this.lessonData,
      datePicked: datePicked ?? this.datePicked,
      status: status ?? this.status,
    );
  }
}
