import 'address.dart';

class ProfileRequest {
  final String? firstName;
  final String? phoneCode;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final String? birthday;
  final String? avatarUrl;
  final Address? address;

  ProfileRequest({
    this.firstName,
    this.phoneCode,
    this.phoneNumber,
    this.email,
    this.birthday,
    this.gender,
    this.address,
    this.avatarUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'first_name': firstName,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'avatar_url': avatarUrl,
    }..removeWhere((key, value) => value == null);
  }
}
