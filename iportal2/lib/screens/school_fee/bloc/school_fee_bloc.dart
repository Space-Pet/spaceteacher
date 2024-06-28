import 'dart:async';

import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/school_fee/bloc/school_fee_status.dart';
import 'package:repository/repository.dart';

part 'school_fee_event.dart';
part 'school_fee_state.dart';

class SchoolFeeBloc extends Bloc<SchoolFeeEvent, SchoolFeeState> {
  SchoolFeeBloc({
    required this.appFetchApiRepo,
    required this.currentUserBloc,
  }) : super(const SchoolFeeState(
            schoolFeeStatus: SchoolFeeStatus.initial,
            schoolFeeHistoryStatus: SchoolFeeHistoryStatus.initial,
            paymentStatus: PaymentStatus.initial)) {
    on<FetchSchoolFee>(_onFetchSchoolFee);
    on<FetchSchoolFeeHistory>(_onFetchSchoolFeeHistory);

    on<GetPaymentGateways>(_onGetPaymentGateways);
    add(const GetPaymentGateways());

    on<OpenPaymentGateway>(_openPaymentGateway);
    on<GetSchoolFeePaymentPreview>(_onGetSchoolFeePaymentPreview);
    on<GetSchoolFeePayWithBalancePreview>(
      _onGetPreviewSchoolFeePayWithBalance,
    );
    on<PayWithBalance>(_onPayWithBalance);
    on<UpdateStatusSchoolFeeEvent>(_onUpdateStatusSchoolFeeEvent);
    on<UpdateTabIndexEvent>(_onUpdateTabIndexEvent);
    on<GetLearnYears>(_onGetLearnYears);
    on<UpdateCurrentYearEvent>(_onUpdateCurrentYear);
  }

  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;

  Future<void> _onFetchSchoolFee(
      FetchSchoolFee event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(schoolFeeStatus: SchoolFeeStatus.loading));
    try {
      final result = await appFetchApiRepo.getSchoolFee(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );
      final schoolPreview = await appFetchApiRepo.getSchoolFeePaymentPreview(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: result.totalThanhTien ?? 0,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );
      emit(
        state.copyWith(
            schoolFeeStatus: SchoolFeeStatus.loaded,
            schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
            schoolFee: result,
            schoolFeePaymentPreview: schoolPreview),
      );
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onFetchSchoolFeeHistory(
      FetchSchoolFeeHistory event, Emitter<SchoolFeeState> emit) async {
    emit(
        state.copyWith(schoolFeeHistoryStatus: SchoolFeeHistoryStatus.loading));

    try {
      final res = await appFetchApiRepo.getHistorySchoolFee(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );

      emit(state.copyWith(
        schoolFeeHistoryStatus: SchoolFeeHistoryStatus.loaded,
        schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
        historySchoolFee: res,
      ));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
        schoolFeeHistoryStatus: SchoolFeeHistoryStatus.error,
        schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
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
        schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
        paymentGateways: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        error: e.toString(),
      ));
    }
  }

  /// chọn gateway
  Future<void> _openPaymentGateway(
      OpenPaymentGateway event, Emitter<SchoolFeeState> emit) async {
    try {
      emit(state.copyWith(paymentStatus: PaymentStatus.loading));
      final res = await appFetchApiRepo.choosePaymentGateway(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: event.totalMoneyPayment,
        paymentId: event.paymentId,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );
      emit(state.copyWith(
        paymentStatus: PaymentStatus.loaded,
        gateway: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        schoolFeeStatus: SchoolFeeStatus.error,
        schoolFeePreviewStatus: SchoolFeePreviewStatus.initial,
        error: e.toString(),
      ));
    }
  }

  /// cấn trừ
  Future<void> _onGetPreviewSchoolFeePayWithBalance(
      GetSchoolFeePayWithBalancePreview event,
      Emitter<SchoolFeeState> emit) async {
    try {
      final resPreview = await appFetchApiRepo.getPreviewSchooWithBalance(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: event.totalMoneyPayment,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );
      Log.d('result: ${resPreview.hinhThucThanhToan}');
      emit(state.copyWith(
        schoolFeePreviewStatus: SchoolFeePreviewStatus.loaded,
        schoolFeePayWithBalancePreview: resPreview,
      ));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
        schoolFeePreviewStatus: SchoolFeePreviewStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onPayWithBalance(
      PayWithBalance event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(paymentStatus: PaymentStatus.loading));
    try {
      final res = await appFetchApiRepo.payWithBalance(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: event.totalMoneyPayment,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );

      emit(state.copyWith(
        paymentStatus: PaymentStatus.loaded,
        isPayWithBalance: res,
      ));
    } catch (e) {
      emit(state.copyWith(
        paymentStatus: PaymentStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onUpdateStatusSchoolFeeEvent(
      UpdateStatusSchoolFeeEvent event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(
      schoolFeeHistoryStatus: event.schoolFeeHistoryStatus,
      schoolFeeStatus: event.schoolFeeStatus,
      paymentStatus: event.paymentStatus,
      schoolFeePreviewStatus: event.schoolFeePreviewStatus,
    ));
  }

  Future<void> _onUpdateTabIndexEvent(
      UpdateTabIndexEvent event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(currentTabIndex: event.tabIndex));
    Log.d(state.currentTabIndex);
  }

  Future<void> _onGetLearnYears(
      GetLearnYears event, Emitter<SchoolFeeState> emit) async {
    emit(state.copyWith(
        schoolFeeGetLearnYearsStatus: SchoolFeeGetLearnYearsStatus.loading));
    try {
      final res = await appFetchApiRepo.getLearnYears(number: event.number);
      final currentYear = res.firstWhere((element) =>
          element.learnYear == currentUserBloc.state.activeChild.learn_year);
      emit(state.copyWith(
          learnYears: res,
          currentYearState: currentYear,
          schoolFeeGetLearnYearsStatus: SchoolFeeGetLearnYearsStatus.loaded));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
          schoolFeeGetLearnYearsStatus: SchoolFeeGetLearnYearsStatus.error,
          error: e.toString()));
    }
  }

  Future<void> _onUpdateCurrentYear(
      UpdateCurrentYearEvent event, Emitter<SchoolFeeState> emit) async {
    emit(
      state.copyWith(
          currentYearState: event.currentYear,
          schoolFeeGetLearnYearsStatus: SchoolFeeGetLearnYearsStatus.updated),
    );
  }

  Future<void> _onGetSchoolFeePaymentPreview(
      GetSchoolFeePaymentPreview event, Emitter<SchoolFeeState> emit) async {
    emit(
        state.copyWith(schoolFeePreviewStatus: SchoolFeePreviewStatus.loading));
    try {
      final res = await appFetchApiRepo.getSchoolFeePaymentPreview(
        pupilId: currentUserBloc.state.activeChild.pupil_id,
        totalMoneyPayment: event.totalMoneyPayment,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            '',
      );
      emit(state.copyWith(
        schoolFeePreviewStatus: SchoolFeePreviewStatus.loaded,
        schoolFeePaymentPreview: res,
      ));
    } catch (e) {
      Log.e("SchoolFeeBloc --> _onGetSchoolFeePaymentPreview: $e");
      emit(state.copyWith(
        schoolFeePreviewStatus: SchoolFeePreviewStatus.error,
        error: e.toString(),
      ));
    }
  }
}
