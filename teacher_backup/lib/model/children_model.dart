import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/url_image_model.dart';

part 'children_model.g.dart';

@JsonSerializable()
class ChildrenModel {
  @JsonKey(name: 'pupil_id')
  final int? pupilID;
  @JsonKey(name: 'user_id')
  final String? userID;
  final String? birthday;
  @JsonKey(name: 'school_id')
  final int? schoolID;
  @JsonKey(name: "school_name")
  final String? schoolName;
  @JsonKey(name: 'class_id')
  final int? classID;
  @JsonKey(name: 'customer_id')
  final int? customerID;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'user_key')
  final String? userKey;
  @JsonKey(name: 'parent_id')
  final int? parentID;
  @JsonKey(name: 'class_name')
  final String? className;
  @JsonKey(name: 'url_image')
  final UrlImageModel? urlImageModel;

  final String? email;
  final String? identifier;

  ChildrenModel({
    this.pupilID,
    this.userID,
    this.birthday,
    this.schoolID,
    this.schoolName,
    this.classID,
    this.customerID,
    this.learnYear,
    this.fullName,
    this.userKey,
    this.parentID,
    this.className,
    this.urlImageModel,
    this.email,
    this.identifier,
  });

  factory ChildrenModel.fromJson(Map<String, dynamic> json) =>
      _$ChildrenModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChildrenModelToJson(this);

  @override
  String toString() {
    return 'ChildrenModel{pupilID: $pupilID, userID: $userID, birthday: $birthday, schoolID: $schoolID, schoolName: $schoolName, classID: $classID, customerID: $customerID, learnYear: $learnYear, fullName: $fullName, userKey: $userKey, parentID: $parentID, className: $className, urlImageModel: $urlImageModel, email: $email, identifier: $identifier}';
  }

  ChildrenModel copyWith({
    int? pupilID,
    String? userID,
    String? birthday,
    int? schoolID,
    String? schoolName,
    int? classID,
    int? customerID,
    String? learnYear,
    String? fullName,
    String? userKey,
    int? parentID,
    String? className,
    UrlImageModel? urlImageModel,
    String? email,
    String? identifier,
  }) {
    return ChildrenModel(
      pupilID: pupilID ?? this.pupilID,
      userID: userID ?? this.userID,
      birthday: birthday ?? this.birthday,
      schoolID: schoolID ?? this.schoolID,
      schoolName: schoolName ?? this.schoolName,
      classID: classID ?? this.classID,
      customerID: customerID ?? this.customerID,
      learnYear: learnYear ?? this.learnYear,
      fullName: fullName ?? this.fullName,
      userKey: userKey ?? this.userKey,
      parentID: parentID ?? this.parentID,
      className: className ?? this.className,
      urlImageModel: urlImageModel ?? this.urlImageModel,
      email: email ?? this.email,
      identifier: identifier ?? this.identifier,
    );
  }

}
