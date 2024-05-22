import 'dart:async';

import 'package:core/core.dart';
import 'package:core/data/models/student_fees.dart';
import 'package:equatable/equatable.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'fee_plan_event.dart';
part 'fee_plan_state.dart';

class FeePlanBloc extends Bloc<FeePlanEvent, FeePlanState> {
  FeePlanBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(const FeePlanState(status: FeePlanStatus.initial)) {
    on<GetListFee>(_onGetListFee);
    add(const GetListFee());
    on<GetFeeRequested>(_onGetFeeRequested);
    add(const GetFeeRequested());
    on<SendFeeRequested>(_onSendFeeRequested);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  Future<void> _onGetListFee(
      GetListFee event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(status: FeePlanStatus.loading));
    final user = currentUserBloc.state.user;
    try {
      final studentFeesData = await appFetchApiRepo.getListFee(
          schoolBrand: user.school_brand,
          schoolId: user.school_id,
          pupilId: user.parent_id,
          learnYear: user.learn_year);
      emit(state.copyWith(
        studentFeesData: studentFeesData,
        status: FeePlanStatus.loaded,
      ));
    } catch (e) {
      Log.e('Error: $e');
      emit(state.copyWith(
        errorsText: e.toString(),
        status: FeePlanStatus.error,
      ));
    }
  }

  Future<void> _onGetFeeRequested(
      GetFeeRequested event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(status: FeePlanStatus.loading));
    final user = currentUserBloc.state.user;
    try {
      final studentFeesRequestedData =
          await appFetchApiRepo.getListFeeRequested(
              schoolBrand: user.school_brand,
              schoolId: user.school_id,
              pupilId: user.parent_id,
              learnYear: user.learn_year);

      emit(state.copyWith(
        studentFeesRequestedData: studentFeesRequestedData,
        status: FeePlanStatus.loaded,
      ));
    } catch (e) {
      Log.e('Error: $e');
      emit(state.copyWith(
        errorsText: e.toString(),
        status: FeePlanStatus.error,
      ));
    }
  }

  Future<void> _onSendFeeRequested(
      SendFeeRequested event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(status: FeePlanStatus.loading));

    final user = currentUserBloc.state.user;

    try {
      final studentFeesData = await appFetchApiRepo.postFeeRequested(
        schoolBrand: user.school_brand,
        schoolId: user.school_id,
        pupilId: user.pupil_id,
        learnYear: user.learn_year,
        listFee: event.listItemFee,
      );

      emit(state.copyWith(
        studentFeesData: studentFeesData,
        status: FeePlanStatus.loaded,
      ));
    } catch (e) {
      Log.e('Error: $e');
      emit(state.copyWith(
        errorsText: e.toString(),
        status: FeePlanStatus.error,
      ));
    }
  }
}
