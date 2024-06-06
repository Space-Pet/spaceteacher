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

