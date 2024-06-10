import 'dart:developer';

import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

part 'create_observation_event.dart';
part 'create_observation_state.dart';

class CreateObservationBloc
    extends Bloc<CreateObservationEvent, CreateObservationState> {
  CreateObservationBloc({
    required this.appFetchApiRepo,
    required this.userKey,
    required this.schoolId,
  }) : super(const CreateObservationState()) {
    on<CreateObservationInit>(_onInit);
    on<TeacherFetched>(_onTeachersFetch);
    on<ObservationCreated>(_onObservationCreate);
    on<DateChanged>(_onDateChange);
    on<SubjectChanged>(_onSubjectChange);
    on<ClassChanged>(_onClassChange);
    on<PeriodChanged>(_onPeriodChange);
    on<InfoChanged>(_onInfoChange);
    on<TeacherSelected>(_onTeacherSelect);
    on<TeacherRemoved>(_onTeacherRemove);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final String userKey;
  final int schoolId;

  void _onInit(
    CreateObservationInit event,
    Emitter<CreateObservationState> emit,
  ) {
    add(TeacherFetched());
    emit(state.copyWith(
      selectedDate: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    ));
  }

  Future<void> _onTeachersFetch(
    TeacherFetched event,
    Emitter<CreateObservationState> emit,
  ) async {
    try {
      final response = await appFetchApiRepo.getTeacherListBySchool(
        schoolId: schoolId,
      );

      log('CreateObservationBloc - _onTeachersFetch - ${response.toString()}');
    } catch (e) {
      log('CreateObservationBloc - _onTeachersFetch - $e');
      emit(state.copyWith(status: CreateObservationStatus.failure));
    }
  }

  Future<void> _onObservationCreate(
    ObservationCreated event,
    Emitter<CreateObservationState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateObservationStatus.loading));

      emit(state.copyWith(status: CreateObservationStatus.success));
    } catch (e) {
      log('ObservationScheduleBloc - Exception - $e');
      emit(state.copyWith(status: CreateObservationStatus.failure));
    }
  }

  void _onDateChange(
    DateChanged event,
    Emitter<CreateObservationState> emit,
  ) {
    final time = DateFormat('dd/MM/yyyy').format(event.time);
    emit(state.copyWith(selectedDate: time));
  }

  void _onSubjectChange(
    SubjectChanged event,
    Emitter<CreateObservationState> emit,
  ) {
    emit(state.copyWith(selectedSubject: event.subject));
  }

  void _onClassChange(
    ClassChanged event,
    Emitter<CreateObservationState> emit,
  ) {
    emit(state.copyWith(selectedClass: event.className));
  }

  void _onPeriodChange(
    PeriodChanged event,
    Emitter<CreateObservationState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
  }

  void _onInfoChange(
    InfoChanged event,
    Emitter<CreateObservationState> emit,
  ) {
    emit(state.copyWith(selectedInfo: event.info));
  }

  void _onTeacherSelect(
    TeacherSelected event,
    Emitter<CreateObservationState> emit,
  ) {
    final selectedTeachers = [...state.selectedTeachers];

    if (selectedTeachers.contains(event.teacher)) {
      selectedTeachers.remove(event.teacher);
    } else {
      selectedTeachers.add(event.teacher);
    }

    emit(state.copyWith(selectedTeachers: selectedTeachers));
  }

  void _onTeacherRemove(
    TeacherRemoved event,
    Emitter<CreateObservationState> emit,
  ) {
    log('CreateObservationBloc - _onTeacherRemove - ${event.teacher.toString()}');
    final selectedTeachers = [...state.selectedTeachers];

    selectedTeachers.remove(event.teacher);

    emit(state.copyWith(selectedTeachers: selectedTeachers));
  }
}
