import 'dart:async';

import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:repository/repository.dart';

part 'school_fee_event.dart';
part 'school_fee_state.dart';

class SchoolFeeBloc extends Bloc<SchoolFeeEvent, SchoolFeeState> {
  SchoolFeeBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(const SchoolFeeState(schoolFeeStatus: SchoolFeeStatus.initial)) {
    on<FetchSchoolFee>(_onFetchSchoolFee);
    add(const FetchSchoolFee());
    on<FetchSchoolFeeHistory>(_onFetchSchoolFeeHistory);
    add(const FetchSchoolFeeHistory());
    on<GetSchoolFeePaymentPreview>(_onGetSchoolFeePaymentPreview);

    on<GetPaymentGateways>(_onGetPaymentGateways);
    add(const GetPaymentGateways());
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  Future<void> _onFetchSchoolFee(
      FetchSchoolFee event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(schoolFeeStatus: SchoolFeeStatus.loading));
    try {
      final res = await appFetchApiRepo.getSchoolFee(
          pupilId: currentUserBloc.state.activeChild.pupil_id);

      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.loaded,
        schoolFee: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onFetchSchoolFeeHistory(
      FetchSchoolFeeHistory event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(schoolFeeStatus: SchoolFeeStatus.loading));

    try {
      final res = await appFetchApiRepo.getHistorySchoolFee(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
      );

      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.loaded,
        historySchoolFee: res,
      ));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGetSchoolFeePaymentPreview(
      GetSchoolFeePaymentPreview event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(schoolFeeStatus: SchoolFeeStatus.loading));

    try {
      final res = await appFetchApiRepo.getSchoolFeePaymentPreview(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: event.totalMoneyPayment,
      );

      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.loaded,
        schoolFeePaymentPreview: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGetPaymentGateways(
      GetPaymentGateways event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(schoolFeeStatus: SchoolFeeStatus.loading));
    try {
      final res = await appFetchApiRepo.getPaymentGateways();
      if (isNullOrEmpty(res)) {
        emit(state.copyWith(
          schoolFeeStatus: SchoolFeeStatus.error,
          error: 'No payment gateways',
        ));
      }
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.loaded,
        paymentGateways: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        error: e.toString(),
      ));
    }
  }
}
