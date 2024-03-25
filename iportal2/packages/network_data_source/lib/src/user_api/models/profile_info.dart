import 'dart:convert';
import 'package:flutter/widgets.dart';

import 'package:local_data_source/local_data_source.dart';

enum SchoolBrand { uka, sga, sna, iec, ischool }

class ProfileInfo {
  final String name;
  final String user_key;
  final int user_id;
  final int school_id;
  final int pupil_id;
  final int type;
  final String type_text;
  final int parent_id;
  final String parent_name;
  final String father_name;
  final String learn_year;
  final String class_name;
  final String school_name;
  final String school_logo;
  final String school_brand;
  final int semester;
  final Children children;
  final TrainingLevel cap_dao_tao;
  ProfileInfo({
    required this.name,
    required this.user_key,
    required this.user_id,
    required this.school_id,
    required this.pupil_id,
    required this.type,
    required this.type_text,
    required this.parent_id,
    required this.parent_name,
    required this.father_name,
    required this.learn_year,
    required this.class_name,
    required this.school_name,
    required this.school_logo,
    required this.school_brand,
    required this.semester,
    required this.children,
    required this.cap_dao_tao,
  });

  ProfileInfo copyWith({
    String? name,
    String? user_key,
    int? user_id,
    int? school_id,
    int? pupil_id,
    int? type,
    String? type_text,
    int? parent_id,
    String? parent_name,
    String? father_name,
    String? learn_year,
    String? class_name,
    String? school_name,
    String? school_logo,
    String? school_brand,
    int? semester,
    Children? children,
    TrainingLevel? cap_dao_tao,
  }) {
    return ProfileInfo(
      name: name ?? this.name,
      user_key: user_key ?? this.user_key,
      user_id: user_id ?? this.user_id,
      school_id: school_id ?? this.school_id,
      pupil_id: pupil_id ?? this.pupil_id,
      type: type ?? this.type,
      type_text: type_text ?? this.type_text,
      parent_id: parent_id ?? this.parent_id,
      parent_name: parent_name ?? this.parent_name,
      father_name: father_name ?? this.father_name,
      learn_year: learn_year ?? this.learn_year,
      class_name: class_name ?? this.class_name,
      school_name: school_name ?? this.school_name,
      school_logo: school_logo ?? this.school_logo,
      school_brand: school_brand ?? this.school_brand,
      semester: semester ?? this.semester,
      children: children ?? this.children,
      cap_dao_tao: cap_dao_tao ?? this.cap_dao_tao,
    );
  }

  // Mầm non:
  // 'C_001', Nhà trẻ'
  // 'C_002', Mẫu giáo
  // Phổ thông
  // 'C_003', Tiểu học
  // 'C_004', Trung học cơ sở
  // 'C_005', 'Trung học phổ thông

  bool isKinderGarten() {
    return ['C_001', 'C_002'].contains(cap_dao_tao.id);
  }

  // school_brand
  // uka -> UK
  // sga -> SGA
  // sna -> SNA
  // iec -> IEC
  // iSchool -> Ischool


  

  bool isUK() {
    return school_brand == 'uka';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'user_key': user_key,
      'user_id': user_id,
      'school_id': school_id,
      'pupil_id': pupil_id,
      'type': type,
      'type_text': type_text,
      'parent_id': parent_id,
      'parent_name': parent_name,
      'father_name': father_name,
      'learn_year': learn_year,
      'class_name': class_name,
      'school_name': school_name,
      'school_logo': school_logo,
      'school_brand': school_brand,
      'semester': semester,
      'children': children.toMap(),
      'cap_dao_tao': cap_dao_tao.toMap(),
    };
  }

  factory ProfileInfo.fromMap(Map<String, dynamic> map) {
    return ProfileInfo(
      name: map['name'] as String,
      user_key: map['user_key'] as String,
      user_id: map['user_id'].toInt() as int,
      school_id: map['school_id'].toInt() as int,
      pupil_id: map['pupil_id'].toInt() as int,
      type: map['type'].toInt() as int,
      type_text: map['type_text'] as String,
      parent_id: map['parent_id'].toInt() as int,
      parent_name: map['parent_name'] as String,
      father_name: map['father_name'] as String,
      learn_year: map['learn_year'] as String,
      class_name: map['class_name'] as String,
      school_name: map['school_name'] as String,
      school_logo: map['school_logo'] as String,
      school_brand: map['school_brand'] as String,
      semester: map['semester'].toInt() as int,
      children: Children.fromMap(map['children'] as Map<String, dynamic>),
      cap_dao_tao:
          TrainingLevel.fromMap(map['cap_dao_tao'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileInfo.notSignedIn() {
    return ProfileInfo(
      name: '--',
      user_key: '--',
      user_id: 0,
      school_id: 0,
      pupil_id: 0,
      type: 0,
      type_text: '--',
      parent_id: 0,
      parent_name: '--',
      father_name: '--',
      learn_year: '--',
      class_name: '--',
      school_name: '--',
      school_logo: '--',
      school_brand: '--',
      semester: 0,
      children: Children(
        pupil_id: 0,
        user_id: '--',
        birthday: '--',
        school_id: 0,
        school_name: '--',
        class_id: 0,
        customer_id: 0,
        learn_year: '--',
        full_name: '--',
        user_key: '--',
        parent_id: 0,
        class_name: '--',
        url_image: UrlImage(
          web: '--',
          mobile: '--',
        ),
      ),
      cap_dao_tao: TrainingLevel(
        id: '--',
        name: '--',
      ),
    );
  }

  factory ProfileInfo.fromJson(String source) =>
      ProfileInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ProfileInfo.fromLocalUser({
    required LocalProfile localProfile,
  }) {
    return ProfileInfo(
      name: localProfile.name,
      user_key: localProfile.user_key,
      user_id: localProfile.user_id,
      school_id: localProfile.school_id,
      pupil_id: localProfile.pupil_id,
      type: localProfile.type,
      type_text: localProfile.type_text,
      parent_id: localProfile.parent_id,
      parent_name: localProfile.parent_name,
      father_name: localProfile.father_name,
      learn_year: localProfile.learn_year,
      class_name: localProfile.class_name,
      school_name: localProfile.school_name,
      school_logo: localProfile.school_logo,
      school_brand: localProfile.school_brand,
      semester: localProfile.semester,
      children: Children.fromLocal(localProfile.children),
      cap_dao_tao: TrainingLevel.fromLocal(localProfile.cap_dao_tao),
    );
  }

  @override
  String toString() {
    return 'ProfileInfo(name: $name, user_key: $user_key, user_id: $user_id, school_id: $school_id, pupil_id: $pupil_id, type: $type, type_text: $type_text, parent_id: $parent_id, parent_name: $parent_name, father_name: $father_name, learn_year: $learn_year, class_name: $class_name, school_name: $school_name, school_logo: $school_logo, school_brand: $school_brand, semester: $semester, children: $children, cap_dao_tao: $cap_dao_tao)';
  }
}

class Children {
  final int pupil_id;
  final String user_id;
  final String birthday;
  final int school_id;
  final String school_name;
  final int class_id;
  final int customer_id;
  final String learn_year;
  final String full_name;
  final String user_key;
  final int parent_id;
  final String class_name;
  final UrlImage url_image;

  Children({
    required this.pupil_id,
    required this.user_id,
    required this.birthday,
    required this.school_id,
    required this.school_name,
    required this.class_id,
    required this.customer_id,
    required this.learn_year,
    required this.full_name,
    required this.user_key,
    required this.parent_id,
    required this.class_name,
    required this.url_image,
  });

  Children copyWith({
    int? pupil_id,
    String? user_id,
    String? birthday,
    int? school_id,
    String? school_name,
    int? class_id,
    int? customer_id,
    String? learn_year,
    String? full_name,
    String? user_key,
    int? parent_id,
    String? class_name,
    UrlImage? url_image,
  }) {
    return Children(
      pupil_id: pupil_id ?? this.pupil_id,
      user_id: user_id ?? this.user_id,
      birthday: birthday ?? this.birthday,
      school_id: school_id ?? this.school_id,
      school_name: school_name ?? this.school_name,
      class_id: class_id ?? this.class_id,
      customer_id: customer_id ?? this.customer_id,
      learn_year: learn_year ?? this.learn_year,
      full_name: full_name ?? this.full_name,
      user_key: user_key ?? this.user_key,
      parent_id: parent_id ?? this.parent_id,
      class_name: class_name ?? this.class_name,
      url_image: url_image ?? this.url_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pupil_id': pupil_id,
      'user_id': user_id,
      'birthday': birthday,
      'school_id': school_id,
      'school_name': school_name,
      'class_id': class_id,
      'customer_id': customer_id,
      'learn_year': learn_year,
      'full_name': full_name,
      'user_key': user_key,
      'parent_id': parent_id,
      'class_name': class_name,
      'url_image': url_image.toMap(),
    };
  }

  factory Children.fromMap(Map<String, dynamic> map) {
    return Children(
      pupil_id: map['pupil_id'].toInt() as int,
      user_id: map['user_id'] as String,
      birthday: map['birthday'] as String,
      school_id: map['school_id'].toInt() as int,
      school_name: map['school_name'] as String,
      class_id: map['class_id'].toInt() as int,
      customer_id: map['customer_id'].toInt() as int,
      learn_year: map['learn_year'] as String,
      full_name: map['full_name'] as String,
      user_key: map['user_key'] as String,
      parent_id: map['parent_id'].toInt() as int,
      class_name: map['class_name'] as String,
      url_image: UrlImage.fromMap(map['url_image'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Children.fromJson(String source) =>
      Children.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Children.fromLocal(LocalChildren localChildren) {
    return Children(
      pupil_id: localChildren.pupil_id,
      user_id: localChildren.user_id,
      birthday: localChildren.birthday,
      school_id: localChildren.school_id,
      school_name: localChildren.school_name,
      class_id: localChildren.class_id,
      customer_id: localChildren.customer_id,
      learn_year: localChildren.learn_year,
      full_name: localChildren.full_name,
      user_key: localChildren.user_key,
      parent_id: localChildren.parent_id,
      class_name: localChildren.class_name,
      url_image: UrlImage.fromLocal(localChildren.url_image),
    );
  }
  @override
  String toString() {
    return 'Children(pupil_id: $pupil_id, user_id: $user_id, birthday: $birthday, school_id: $school_id, school_name: $school_name, class_id: $class_id, customer_id: $customer_id, learn_year: $learn_year, full_name: $full_name, user_key: $user_key, parent_id: $parent_id, class_name: $class_name, url_image: $url_image)';
  }
}

class UrlImage {
  final String web;
  final String mobile;
  UrlImage({
    required this.web,
    required this.mobile,
  });

  UrlImage copyWith({
    String? web,
    String? mobile,
  }) {
    return UrlImage(
      web: web ?? this.web,
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'web': web,
      'mobile': mobile,
    };
  }

  factory UrlImage.fromMap(Map<String, dynamic> map) {
    return UrlImage(
      web: map['web'] as String,
      mobile: map['mobile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UrlImage.fromJson(String source) =>
      UrlImage.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UrlImage.fromLocal(LocalUrlImage localUrlImage) {
    return UrlImage(web: localUrlImage.web, mobile: localUrlImage.mobile);
  }

  @override
  String toString() => 'UrlImage(web: $web, mobile: $mobile)';
}

class TrainingLevel {
  final String id;
  final String name;
  TrainingLevel({
    required this.id,
    required this.name,
  });

  TrainingLevel copyWith({
    String? id,
    String? name,
  }) {
    return TrainingLevel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory TrainingLevel.fromMap(Map<String, dynamic> map) {
    return TrainingLevel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingLevel.fromJson(String source) =>
      TrainingLevel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory TrainingLevel.fromLocal(LocalTrainingLevel localTrainingLevel) {
    return TrainingLevel(
        id: localTrainingLevel.id, name: localTrainingLevel.name);
  }

  @override
  String toString() => 'Cap_dao_tao(id: $id, name: $name)';
}
