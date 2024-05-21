class BusItemModel {
  final int id;
  final String route;
  final String busId;
  final String title;
  final String routeType;
  final String pickupLocation;
  final String estimatedTime;
  final String teacherName;
  final String teacherPhone;
  final String driverName;
  final String date;

  BusItemModel({
    required this.id,
    required this.route,
    required this.busId,
    required this.title,
    required this.routeType,
    required this.pickupLocation,
    required this.estimatedTime,
    required this.teacherName,
    required this.teacherPhone,
    required this.driverName,
    required this.date,
  });
}

final List<BusItemModel> busItemList = [
  BusItemModel(
      id: 1,
      title: 'Học sinh xuống xe lúc - 16:30',
      route: 'H230394',
      busId: '72-C2 30394',
      routeType: 'Xuống xe',
      pickupLocation: '14 Trần Hưng Đạo, Vũng Tàu',
      estimatedTime: '6:25',
      teacherName: 'Nguyễn Minh Nhi',
      driverName: 'Trần Minh Trí',
      teacherPhone: '0909090908',
      date: '29/02/2024'),
  BusItemModel(
      id: 2,
      title: 'Học sinh lên xe lúc - 6:30',
      route: 'H230394',
      busId: '72-C2 30394',
      routeType: 'Xuống xe',
      pickupLocation: '14 Trần Hưng Đạo, Vũng Tàu',
      estimatedTime: '6:25',
      teacherName: 'Nguyễn Minh Nhi',
      driverName: 'Trần Minh Trí',
      teacherPhone: '0909090908',
      date: '29/02/2024'),
  BusItemModel(
      id: 3,
      title: 'Học sinh xuống xe lúc - 16:30',
      route: 'H230394',
      busId: '72-C2 30394',
      routeType: 'Xuống xe',
      pickupLocation: '14 Trần Hưng Đạo, Vũng Tàu',
      estimatedTime: '6:25',
      teacherName: 'Nguyễn Minh Nhi',
      driverName: 'Trần Minh Trí',
      teacherPhone: '0909090908',
      date: '29/02/2024'),
  BusItemModel(
      id: 4,
      title: 'Học sinh lên xe lúc - 16:30',
      route: 'H230394',
      busId: '72-C2 30394',
      routeType: 'Xuống xe',
      pickupLocation: '14 Trần Hưng Đạo, Vũng Tàu',
      estimatedTime: '6:25',
      teacherName: 'Nguyễn Minh Nhi',
      driverName: 'Trần Minh Trí',
      teacherPhone: '0909090908',
      date: '29/02/2024'),
];
