import 'package:json_annotation/json_annotation.dart';

import '../../common/constants.dart';

part 'booking_setting.g.dart';

@JsonSerializable()
class BookingSetting {
  String? id;
  double? value;

  BookingSetting(
    this.id,
    this.value,
  );

  factory BookingSetting.fromJson(Map<String, dynamic> json) =>
      _$BookingSettingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingSettingToJson(this);

  bool get isBookingBuffer => id == BookingSettingConstant.bookingBuffer;
}
