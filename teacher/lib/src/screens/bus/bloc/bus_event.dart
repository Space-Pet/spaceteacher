part of 'bus_bloc.dart';

abstract class BusEvent extends Equatable {
  const BusEvent();

  @override
  List<Object> get props => [];
}

class BusFetchedSchedules extends BusEvent {
  final String startDate;
  final String endDate;
  final String schoolBrand;
  final int schoolId;
  final int routeId;

  const BusFetchedSchedules({
    this.startDate = '',
    this.endDate = '',
    this.schoolBrand = '',
    this.schoolId = 0,
    this.routeId = 0,
  });
  @override
  List<Object> get props =>
      [startDate, endDate, schoolBrand, schoolId, routeId];
}

class BusChangedDate extends BusEvent {
  final String startDate;
  final String endDate;
  final String schoolBrand;
  final int schoolId;

  const BusChangedDate({
    this.startDate = '',
    this.endDate = '',
    this.schoolBrand = '',
    this.schoolId = 0,
  });

  @override
  List<Object> get props => [startDate, endDate, schoolBrand, schoolId];
}
