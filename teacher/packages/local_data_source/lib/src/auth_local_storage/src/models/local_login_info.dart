// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'local_login_info.g.dart';

@HiveType(typeId: 2)
class LocalLoginInfo {
  @HiveField(0)
  final String email;
  @HiveField(2)
  final String password;

  LocalLoginInfo({
    required this.email,
    required this.password,
  });
}
