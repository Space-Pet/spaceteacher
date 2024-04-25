import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/absence_form_detail_model.dart';
import 'package:teacher/model/link_model.dart';
import 'package:teacher/model/meta_model.dart';
part 'history_absence_model.g.dart';

@JsonSerializable()
class HistoryAbsenceModel {
  @JsonKey(name: 'data')
  final List<AbsenceFormDetailModel>? listData;
  final Links? links;
  final Meta? meta;

  HistoryAbsenceModel({this.listData, this.links, this.meta});

  factory HistoryAbsenceModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryAbsenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryAbsenceModelToJson(this);

  @override
  String toString() {
    return 'HistoryAbsenceModel{listData: $listData, links: $links, meta: $meta}';
  }

  HistoryAbsenceModel copyWith({
    List<AbsenceFormDetailModel>? listData,
    Links? links,
    Meta? meta,
  }) {
    return HistoryAbsenceModel(
      listData: listData ?? this.listData,
      links: links ?? this.links,
      meta: meta ?? this.meta,
    );
  }
}
