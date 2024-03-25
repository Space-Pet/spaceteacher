import 'package:json_annotation/json_annotation.dart';
part 'booking_partner_assistant.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingPartnerAssistant {
  String? address;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;
  @JsonKey(name: 'booking_id')
  String? bookingId;
  @JsonKey(name: 'full_name')
  String? fullName;
  String? gender;
  @JsonKey(name: 'id_back_url')
  String? idBackUrl;
  @JsonKey(name: 'id_front_url')
  String? idFrontUrl;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  BookingPartnerAssistant(
      {this.address,
      this.avatarUrl,
      this.bookingId,
      this.fullName,
      this.gender,
      this.idBackUrl,
      this.idFrontUrl,
      this.phoneNumber,});
  factory BookingPartnerAssistant.fromJson(Map<String, dynamic> json) =>
      _$BookingPartnerAssistantFromJson(json);

  Map<String, dynamic> toJson() => _$BookingPartnerAssistantToJson(this);
}
