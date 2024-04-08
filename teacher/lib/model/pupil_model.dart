import 'package:json_annotation/json_annotation.dart';
part 'pupil_model.g.dart';

@JsonSerializable()
class PupilModel {
  @JsonKey(name: 'pupil_id')
  final int? pupilID;
  final String? name;
  @JsonKey(name: 'user_id')
  final String? userID;
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'customer_id')
  final int? customerID;
  final String? birthday;
  final String? address;
  final String? email;
  final String? phone;
  final int? status;
  @JsonKey(name: 'status_text')
  final String? statusText;
  final String? identifier;

  PupilModel({
    this.pupilID,
    this.name,
    this.userID,
    this.userKey,
    this.learnYear,
    this.customerID,
    this.birthday,
    this.address,
    this.email,
    this.phone,
    this.status,
    this.statusText,
    this.identifier,
  });

  factory PupilModel.fromJson(Map<String, dynamic> json) =>
      _$PupilModelFromJson(json);

  Map<String, dynamic> toJson() => _$PupilModelToJson(this);

  @override
  String toString() {
    return 'PupilModel{pupilID: $pupilID, name: $name, userID: $userID, userKey: $userKey, learnYear: $learnYear, customerID: $customerID, birthday: $birthday, address: $address, email: $email, phone: $phone, status: $status, statusText: $statusText, identifier: $identifier,}';
  }

  PupilModel copyWith({
    int? pupilID,
    String? name,
    String? userID,
    String? userKey,
    String? learnYear,
    int? customerID,
    String? birthday,
    String? address,
    String? email,
    String? phone,
    int? status,
    String? statusText,
    String? identifier,
  }) {
    return PupilModel(
      pupilID: pupilID ?? this.pupilID,
      name: name ?? this.name,
      userID: userID ?? this.userID,
      userKey: userKey ?? this.userKey,
      learnYear: learnYear ?? this.learnYear,
      customerID: customerID ?? this.customerID,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      identifier: identifier ?? this.identifier,
    );
  }
}
