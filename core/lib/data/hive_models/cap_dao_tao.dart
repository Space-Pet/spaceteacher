import 'package:hive_flutter/hive_flutter.dart';

part 'cap_dao_tao.g.dart';

@HiveType(typeId: 16)
class CapDaoTao {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  CapDaoTao({
    required this.id,
    required this.name,
  });

  factory CapDaoTao.fromMap(Map<String, dynamic> map) {
    return CapDaoTao(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
