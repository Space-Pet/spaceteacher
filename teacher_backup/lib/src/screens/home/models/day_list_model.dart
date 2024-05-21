import 'package:json_annotation/json_annotation.dart';
part 'day_list_model.g.dart';

@JsonSerializable()
class DayList {
  final String? description; // môn học vắng
  final String? isAbsent; // vắng có phép hoặc không phép

  DayList({this.description, this.isAbsent});

  factory DayList.fromJson(Map<String, dynamic> json) =>
      _$DayListFromJson(json);

  Map<String, dynamic> toJson() => _$DayListToJson(this);

  DayList copyWith({
    String? description,
    String? isAbsent,
  }) {
    return DayList(
      description: description ?? this.description,
      isAbsent: isAbsent ?? this.isAbsent,
    );
  }

  @override
  String toString() {
    return 'DayList{description: $description, isAbsent: $isAbsent}';
  }
}
