import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teacher/model/bus_model.dart';
import 'package:teacher/repository/bus_repository/bus_repositories.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  BusBloc({required this.busRepository})
      : super(BusState(
          selectedDate: DateTime.now(),
        )) {
    on<BusFetchedSchedules>(_onFetchSchedules);
    // on<BusChangedDate>(_onChangedDate);
  }

  final BusRepository busRepository;

  _onFetchSchedules(BusFetchedSchedules event, Emitter<BusState> emit) async {
    emit(state.copyWith(status: BusStatus.loading));

    final busSchedules = await busRepository.getListBusSchedule(
      startDate: event.startDate,
      endDate: event.endDate,
      schoolBrand: event.schoolBrand,
      schoolId: event.schoolId,
    );
    emit(state.copyWith(
        busSchedules: busSchedules.listBusSchedule, status: BusStatus.success));
  }

  // _onChangedDate(BusChangedDate event, Emitter<BusState> emit) {
  //   emit(state.copyWith(
  //     selectedDate: event.date,
  //   ));
  //   add(const BusFetchedSchedules());
  // }
}
