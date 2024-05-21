import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/url_image_model.dart';

part 'pupil_contact_student_model.g.dart';

@JsonSerializable()
class PupilContactStudentModel {
  @JsonKey(name: 'pupil_id')
  final int? pupilID;
  @JsonKey(name: 'full_name')
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
  final String? email;
  final String? identifier;

  @JsonKey(name: 'school_id')
  final int? schoolID;
  @JsonKey(name: 'school_name')
  final String? schoolName;
  @JsonKey(name: 'class_id')
  final int? classID;
  @JsonKey(name: 'class_name')
  final String? className;
  @JsonKey(name: 'url_image')
  final UrlImageModel? urlImage;
  @JsonKey(name: 'parent_id')
  final int? parentID;

  PupilContactStudentModel({
    this.pupilID,
    this.name,
    this.userID,
    this.userKey,
    this.learnYear,
    this.customerID,
    this.birthday,
    this.email,
    this.identifier,
    this.schoolID,
    this.schoolName,
    this.classID,
    this.className,
    this.urlImage,
    this.parentID,
  });

  factory PupilContactStudentModel.fromJson(Map<String, dynamic> json) =>
      _$PupilContactStudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PupilContactStudentModelToJson(this);

  @override
  String toString() {
    return 'PupilContactStudentModel{pupilID: $pupilID, name: $name, userID: $userID, userKey: $userKey, learnYear: $learnYear, customerID: $customerID, birthday: $birthday, email: $email, identifier: $identifier, schoolID: $schoolID, schoolName: $schoolName, classID: $classID, className: $className, urlImage: $urlImage, parentID: $parentID}';
  }

  PupilContactStudentModel copyWith({
    int? pupilID,
    String? name,
    String? userID,
    String? userKey,
    String? learnYear,
    int? customerID,
    String? birthday,
    String? address,
    String? email,
    String? identifier,
    int? schoolID,
    String? schoolName,
    int? classID,
    String? className,
    UrlImageModel? urlImage,
    int? parentID,
  }) {
    return PupilContactStudentModel(
      pupilID: pupilID ?? this.pupilID,
      name: name ?? this.name,
      userID: userID ?? this.userID,
      userKey: userKey ?? this.userKey,
      learnYear: learnYear ?? this.learnYear,
      customerID: customerID ?? this.customerID,
      birthday: birthday ?? this.birthday,
      email: email ?? this.email,
      identifier: identifier ?? this.identifier,
      schoolID: schoolID ?? this.schoolID,
      schoolName: schoolName ?? this.schoolName,
      classID: classID ?? this.classID,
      className: className ?? this.className,
      urlImage: urlImage ?? this.urlImage,
      parentID: parentID ?? this.parentID,
    );
  }
}
