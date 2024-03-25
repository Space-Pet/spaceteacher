import 'adminstrative.dart';

class ActiveDistrict {
  final List<District>? districts;
  final Province? province;

  ActiveDistrict({this.districts, this.province});

  ActiveDistrict copyWith(
    List<District>? districts,
    Province? province,
  ) {
    return ActiveDistrict(
      districts: districts ?? this.districts,
      province: province ?? this.province,
    );
  }
}
