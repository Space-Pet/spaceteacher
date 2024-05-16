import 'dart:async';

import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:teacher/model/hourly_assessment_detail_model.dart';
import 'package:teacher/repository/observation_repository/observation_repositories.dart';

part 'observatiom_schedule_event.dart';
part 'observation_schedule_state.dart';

class ObservationScheduleBloc
    extends Bloc<ObservationScheduleEvent, ObservationScheduleState> {
  ObservationScheduleBloc({required this.observationRepository})
      : super(
          const ObservationScheduleState(
              status: ObservationScheduleStatus.initial),
        ) {
    on<GetObservationSchedule>(_onGetObservationSchedule);
    on<CreateHourlyAssessment>(_onCreateHourlyAssessment);
    on<UpdateHourlyAssessment>(_onUpdateHourlyAssessment);
    on<GetListHourlyAssessmentDetail>(_onGetListHourlyAssessmentDetail);
    on<GetEvaluateEngLish>(_onGetEvaluateEngLish);
    on<GetEvaluateMOET>(_onGetEvaluateMOET);
  }

  final ObservationRepository observationRepository;
  Future<void> _onGetObservationSchedule(GetObservationSchedule event,
      Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      final data = await observationRepository.getObservationSchedule(
        userKey: event.userKey,
        classId: event.classId,
        dateFrom: event.dateFrom,
        dateTo: event.dateTo,
      );
      emit(state.copyWith(
          listHourlyAssessmentDetail: data.listHourlyAssessment,
          status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onGetObservationSchedule');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onGetObservationSchedule ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> _onCreateHourlyAssessment(CreateHourlyAssessment event,
      Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      await observationRepository.createHourlyAssessment(
        userKey: event.userKey,
        teacherId: event.teacherId,
        classId: event.classId,
        subjectId: event.subjectId,
        schoolId: event.schoolId,
        date: event.date,
        tietNum: event.tietNum,
      );
      emit(state.copyWith(status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onCreateHourlyAssessment');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onCreateHourlyAssessment ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> _onUpdateHourlyAssessment(UpdateHourlyAssessment event,
      Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      await observationRepository.updateHourlyAssessment(
        userKey: event.userKey,
        lessonRegisterId: event.lessonRegisterId,
        noteId: event.noteId,
        diemDat: event.diemDat,
        tieuChiDiem: event.tieuChiDiem,
        nhanXet: event.nhanXet,
      );
      emit(state.copyWith(status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onUpdateHourlyAssessment');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onUpdateHourlyAssessment ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> _onGetListHourlyAssessmentDetail(
      GetListHourlyAssessmentDetail event,
      Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      final data = await observationRepository.getListHourlyAssessmentDetail(
        userKey: event.userKey,
        schoolId: event.schoolId,
        date: event.date,
        teacherId: event.teacherId,
      );
      emit(state.copyWith(
          listHourlyAssessmentDetail: data,
          status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e',
          name: 'ObservationScheduleBloc -> _onGetListHourlyAssessmentDetail');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onGetListHourlyAssessmentDetail ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> _onGetEvaluateEngLish(
      GetEvaluateEngLish event, Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      await observationRepository.getEvaluateEnglishHourlyAssessment(
        userKey: event.userKey,
        lessonRegisterId: event.lessonRegisterId,
      );
      emit(state.copyWith(status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onGetEvaluateEngLish');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onGetEvaluateEngLish ${e.toString()}'));
      rethrow;
    }
  }

  Future<void> _onGetEvaluateMOET(
      GetEvaluateMOET event, Emitter<ObservationScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ObservationScheduleStatus.loading));
      await observationRepository.getEvaluateMOETHourlyAssessment(
        userKey: event.userKey,
        lessonRegisterId: event.lessonRegisterId,
      );
      emit(state.copyWith(status: ObservationScheduleStatus.loaded));
    } catch (e) {
      Log.e('$e', name: 'ObservationScheduleBloc -> _onGetEvaluateMOET');
      emit(state.copyWith(
          status: ObservationScheduleStatus.error,
          errorString:
              'ObservationScheduleBloc -> _onGetEvaluateMOET ${e.toString()}'));
      rethrow;
    }
  }
}
