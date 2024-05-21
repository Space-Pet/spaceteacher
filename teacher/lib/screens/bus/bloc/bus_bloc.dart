import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  BusBloc(
    this.appApiRepository, {
    required this.pupilId,
    required this.schoolId,
    required this.schoolBrand,
  }) : super(BusState(
          selectedDate: DateTime.now(),
        )) {
    on<BusFetchedSchedules>(_onFetchSchedules);
    on<BusChangedDate>(_onChangedDate);

    add(BusFetchedSchedules());
  }
  final int pupilId;
  final int schoolId;
  final String schoolBrand;

  final AppFetchApiRepository appApiRepository;

  _onFetchSchedules(BusFetchedSchedules event, Emitter<BusState> emit) async {
    emit(state.copyWith(status: BusStatus.loading));

    final busSchedules = await appApiRepository.getBusSchedules(
      pupilId: pupilId,
      startDate: state.selectedDate,
      schoolBrand: schoolBrand,
      schoolId: schoolId,
    );
    emit(state.copyWith(busSchedules: busSchedules, status: BusStatus.success));
  }

  _onChangedDate(BusChangedDate event, Emitter<BusState> emit) {
    emit(state.copyWith(
      selectedDate: event.date,
    ));
    add(BusFetchedSchedules());
  }
}
