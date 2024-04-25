import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/menu_in_week_data_model.dart';
part 'menu_in_week_model.g.dart';

@JsonSerializable()
class MenuInWeekModel {
  @JsonKey(name: 'txt_current_week')
  final String? txtCurrentWeek;
  @JsonKey(name: 'txt_week')
  final String? txtWeek;
  @JsonKey(name: 'txt_begin_day')
  final String? txtBeginDay;
  @JsonKey(name: 'txt_end_day')
  final String? txtEndDay;
  @JsonKey(name: 'txt_pre_week')
  final String? txtPreWeek;
  @JsonKey(name: 'txt_next_week')
  final String? txtNextWeek;
  @JsonKey(name: 'data')
  final List<MenuInWeekDataModel>? listMenuInWeekData;

  MenuInWeekModel({
    this.txtCurrentWeek,
    this.txtWeek,
    this.txtBeginDay,
    this.txtEndDay,
    this.txtPreWeek,
    this.txtNextWeek,
    this.listMenuInWeekData,
  });

  factory MenuInWeekModel.fromJson(Map<String, dynamic> json) =>
      _$MenuInWeekModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuInWeekModelToJson(this);

  @override
  String toString() {
    return 'MenuInWeekModel{txtCurrentWeek: $txtCurrentWeek, txtWeek: $txtWeek, txtBeginDay: $txtBeginDay, txtEndDay: $txtEndDay, txtPreWeek: $txtPreWeek, txtNextWeek: $txtNextWeek, listMenuInWeekData: $listMenuInWeekData}';
  }

  MenuInWeekModel copyWith({
    String? txtCurrentWeek,
    String? txtWeek,
    String? txtBeginDay,
    String? txtEndDay,
    String? txtPreWeek,
    String? txtNextWeek,
    List<MenuInWeekDataModel>? listMenuInWeekData,
  }) {
    return MenuInWeekModel(
      txtCurrentWeek: txtCurrentWeek ?? this.txtCurrentWeek,
      txtWeek: txtWeek ?? this.txtWeek,
      txtBeginDay: txtBeginDay ?? this.txtBeginDay,
      txtEndDay: txtEndDay ?? this.txtEndDay,
      txtPreWeek: txtPreWeek ?? this.txtPreWeek,
      txtNextWeek: txtNextWeek ?? this.txtNextWeek,
      listMenuInWeekData: listMenuInWeekData ?? this.listMenuInWeekData,
    );
  }
}
