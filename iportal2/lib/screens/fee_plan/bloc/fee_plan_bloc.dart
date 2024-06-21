import 'dart:async';

import 'package:core/core.dart';
import 'package:iportal2/common_bloc/current_user/bloc/current_user_bloc.dart';
import 'package:iportal2/screens/fee_plan/bloc/fee_plan_status.dart';
import 'package:repository/repository.dart';

part 'fee_plan_event.dart';
part 'fee_plan_state.dart';

class FeePlanBloc extends Bloc<FeePlanEvent, FeePlanState> {
  FeePlanBloc(
    this.appFetchApiRepo, {
    required this.currentUserBloc,
    required this.userRepository,
  }) : super(const FeePlanState(
          status: FeePlanStatus.initial,
          listVerify: [],
        )) {
    on<GetListFee>(_onGetListFee);
    on<GetFeeRequested>(_onGetFeeRequested);
    on<SendFeeRequested>(_onSendFeeRequested);
    on<AddFeeToListVerify>(_onAddFeeToListVerify);
    on<RemoveFeeFromListVerify>(_onRemoveFeeFromListVerify);
    on<GetListLearnYear>(_onGetLearnYears);
    on<UpdateCurrentYear>(_onUpdateCurrentYear);
    on<UpdateCurrentTabIndex>(_onUpdateTabIndexEvent);
    on<UpdateStatusFeePlan>(_onUpdateStatusFeePlan);
  }
  final AppFetchApiRepository appFetchApiRepo;
  final CurrentUserBloc currentUserBloc;
  final UserRepository userRepository;

  Future<void> _onGetListFee(
      GetListFee event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(status: FeePlanStatus.loading));
    final user = currentUserBloc.state.activeChild;
    try {
      final studentFeesData = await appFetchApiRepo.getListFee(
        schoolBrand: user.school_brand,
        schoolId: user.school_id,
        pupilId: user.pupil_id,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            "",
      );
      emit(state.copyWith(
        studentFeesData: studentFeesData,
        status: FeePlanStatus.loaded,
        listVerify: [],
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
    emit(state.copyWith(historyStatus: FeePlanHistoryStatus.loading));
    final user = currentUserBloc.state.activeChild;
    try {
      final studentFeesRequestedData =
          await appFetchApiRepo.getListFeeRequested(
        schoolBrand: user.school_brand,
        schoolId: user.school_id,
        pupilId: user.pupil_id,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            "",
      );

      emit(state.copyWith(
        studentFeesRequestedData: studentFeesRequestedData,
        historyStatus: FeePlanHistoryStatus.loaded,
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

    final user = currentUserBloc.state.activeChild;
    emit(state.copyWith(sendRequestStatus: FeePlanSendRequestStatus.loading));
    try {
      final studentFeesData = await appFetchApiRepo.postFeeRequested(
        schoolBrand: user.school_brand,
        schoolId: user.school_id,
        pupilId: user.pupil_id,
        learnYear: event.learnYear ??
            currentUserBloc.state.activeChild.learn_year ??
            "",
        listFee: event.listItemFee,
      );

      emit(state.copyWith(
          studentFeesData: studentFeesData,
          sendRequestStatus: FeePlanSendRequestStatus.loaded));
    } catch (e) {
      Log.e('Error: $e');
      emit(state.copyWith(
        errorsText: e.toString(),
        status: FeePlanStatus.error,
      ));
    }
  }

  Future<void> _onRemoveFeeFromListVerify(
      RemoveFeeFromListVerify event, Emitter<FeePlanState> emit) async {
    try {
      final listVerify = List<FeeItem>.from(state.listVerify ?? []);
      listVerify.removeWhere((element) => element.id == event.feeItem.id);
      emit(state.copyWith(listVerify: listVerify));
    } catch (e) {
      Log.e('Error: $e');
    }
  }

  Future<void> _onAddFeeToListVerify(
      AddFeeToListVerify event, Emitter<FeePlanState> emit) async {
    try {
      final listVerify = List<FeeItem>.from(state.listVerify ?? []);
      listVerify.add(event.feeItem);
      emit(state.copyWith(listVerify: listVerify));
    } catch (e) {
      Log.e('Error: $e');
    }
  }

  Future<void> _onGetLearnYears(
      GetListLearnYear event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(learnYearsStatus: FeePlanLearnYearsStatus.loading));
    try {
      final res = await appFetchApiRepo.getLearnYears(number: event.number);
      final currentYear = res.firstWhere((element) =>
          element.learnYear == currentUserBloc.state.activeChild.learn_year);
      emit(state.copyWith(
          learnYears: res,
          currentYearState: currentYear,
          learnYearsStatus: FeePlanLearnYearsStatus.loaded));
    } catch (e) {
      Log.e(e.toString());
      emit(state.copyWith(
          learnYearsStatus: FeePlanLearnYearsStatus.error,
          errorsText: e.toString()));
    }
  }

  Future<void> _onUpdateCurrentYear(
      UpdateCurrentYear event, Emitter<FeePlanState> emit) async {
    emit(
      state.copyWith(
        currentYearState: event.currentYearState,
        learnYearsStatus: FeePlanLearnYearsStatus.updated,
      ),
    );
  }

  Future<void> _onUpdateTabIndexEvent(
      UpdateCurrentTabIndex event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(currentTabIndex: event.currentTabIndex));
    Log.d(state.currentTabIndex);
  }

  Future<void> _onUpdateStatusFeePlan(
      UpdateStatusFeePlan event, Emitter<FeePlanState> emit) async {
    emit(state.copyWith(
      status: event.status,
      sendRequestStatus: event.sendRequestStatus,
      historyStatus: event.historyStatus,
      learnYearsStatus: event.learnYearsStatus,
    ));
  }
}
