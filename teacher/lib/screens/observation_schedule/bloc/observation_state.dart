part of 'observation_bloc.dart';

class ObservationState extends Equatable {
  const ObservationState({
    this.status = ObservationStatus.initial,
    this.registeredstatus = ObservationStatus.initial,
    this.teacherList = const <TeacherItem>[],
    this.teacherSelected,
    required this.datePicked,
    required this.observationList,
    required this.datePickedRegistered,
    required this.registeredLessonList,
    this.selectedSubject,
    this.selectedClass,
    this.selectedInfo,
  });

  final ObservationStatus status;
  final ObservationStatus registeredstatus;
  final List<TeacherItem> teacherList;
  final TeacherItem? teacherSelected;
  final DateTime datePicked;
  final List<ObservationData> observationList;

  final DateTime datePickedRegistered;
  final List<RegisteredLesson> registeredLessonList;

  final String? selectedSubject;
  final String? selectedClass;
  final String? selectedInfo;

  ObservationState copyWith({
    ObservationStatus? status,
    ObservationStatus? registeredstatus,
    List<TeacherItem>? teacherList,
    TeacherItem? teacherSelected,
    DateTime? datePicked,
    List<ObservationData>? observationList,
    DateTime? datePickedRegistered,
    List<RegisteredLesson>? registeredLessonList,
    String? selectedSubject,
    String? selectedClass,
    String? selectedInfo,
  }) {
    return ObservationState(
      status: status ?? this.status,
      registeredstatus: registeredstatus ?? this.registeredstatus,
      teacherList: teacherList ?? this.teacherList,
      teacherSelected: teacherSelected ?? this.teacherSelected,
      datePicked: datePicked ?? this.datePicked,
      observationList: observationList ?? this.observationList,
      datePickedRegistered: datePickedRegistered ?? this.datePickedRegistered,
      registeredLessonList: registeredLessonList ?? this.registeredLessonList,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedInfo: selectedInfo ?? this.selectedInfo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        registeredstatus,
        teacherList,
        teacherSelected,
        datePicked,
        selectedSubject,
        selectedClass,
        selectedInfo,
        observationList,
        datePickedRegistered,
        registeredLessonList,
      ];
}

enum ObservationStatus {
  initial,
  loading,
  success,
  failure,
  loadingTeachers,
  successTeachers,
  failureTeachers,
  loadingRegister,
  successRegister,
  failureRegister,
  loadingRegisteredLesson,
  successRegisteredLesson,
  failureRegisteredLesson,
  successDelete,
  failureDelete,
}

extension ObservationStatusX on ObservationStatus {
  bool get isInitial => this == ObservationStatus.initial;
  bool get isLoading => this == ObservationStatus.loading;
  bool get isSuccess => this == ObservationStatus.success;
  bool get isFailure => this == ObservationStatus.failure;
}
