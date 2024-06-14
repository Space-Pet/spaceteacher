part of 'filter_observation_bloc.dart';

enum FilterObservationStatus { initial, loading, success, failure }

class FilterObservationState extends Equatable {
  const FilterObservationState({
    this.status = FilterObservationStatus.initial,
    this.date,
    this.teacher,
    this.listTeacher = const [],
  });

  final FilterObservationStatus status;
  final String? date;
  final String? teacher;
  final List<TeacherItem> listTeacher;

  FilterObservationState copyWith({
    FilterObservationStatus? status,
    String? date,
    String? teacher,
    List<TeacherItem>? listTeacher,
  }) {
    return FilterObservationState(
      status: status ?? this.status,
      date: date ?? this.date,
      teacher: teacher ?? this.teacher,
      listTeacher: listTeacher ?? this.listTeacher,
    );
  }

  @override
  List<Object?> get props => [
        status,
        date,
        teacher,
        listTeacher,
      ];
}
