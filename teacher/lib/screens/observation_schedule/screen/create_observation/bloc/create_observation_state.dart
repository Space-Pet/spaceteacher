part of 'create_observation_bloc.dart';

enum CreateObservationStatus { initial, loading, success, failure }

extension CreateObservationStatusX on CreateObservationStatus {
  bool get isInitial => this == CreateObservationStatus.initial;
  bool get isLoading => this == CreateObservationStatus.loading;
  bool get isSuccess => this == CreateObservationStatus.success;
  bool get isFailure => this == CreateObservationStatus.failure;
}

class CreateObservationState extends Equatable {
  const CreateObservationState({
    this.status = CreateObservationStatus.initial,
    this.teacherList = const <TeacherItem>[],
    this.selectedTeachers = const <TeacherItem>[],
    this.selectedDate,
    this.selectedSubject,
    this.selectedClass,
    this.selectedPeriod,
    this.selectedInfo,
  });

  final CreateObservationStatus status;
  final List<TeacherItem> teacherList;
  final List<TeacherItem> selectedTeachers;
  final String? selectedDate;
  final String? selectedSubject;
  final String? selectedClass;
  final String? selectedPeriod;
  final String? selectedInfo;

  CreateObservationState copyWith({
    CreateObservationStatus? status,
    List<TeacherItem>? teacherList,
    List<TeacherItem>? selectedTeachers,
    String? selectedDate,
    String? selectedSubject,
    String? selectedClass,
    String? selectedPeriod,
    String? selectedInfo,
  }) {
    return CreateObservationState(
      status: status ?? this.status,
      teacherList: teacherList ?? this.teacherList,
      selectedTeachers: selectedTeachers ?? this.selectedTeachers,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedSubject: selectedSubject ?? this.selectedSubject,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      selectedInfo: selectedInfo ?? this.selectedInfo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        teacherList,
        selectedTeachers,
        selectedDate,
        selectedSubject,
        selectedClass,
        selectedPeriod,
        selectedInfo,
      ];
}
