import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/conduct_primary_school_data_model.dart';
part 'conduct_primary_school_model.g.dart';

@JsonSerializable()
class ConductPrimarySchoolModel {
  @JsonKey(name: 'pupil_id')
  final String? pupilId;
  @JsonKey(name: 'learn_year')
  final String? learnYear;
  @JsonKey(name: 'txt_hoc_ky')
  final String? hocKy;
  @JsonKey(name: 'hk_tih_value')
  final String? hkTihValue;
  final String? status;
  @JsonKey(name: 'status_note')
  final String? statusNote;
  @JsonKey(name: 'data')
  final ConductPrimarySchoolDataModel? conductPrimarySchoolDataModel;

  ConductPrimarySchoolModel({
    this.pupilId,
    this.learnYear,
    this.hocKy,
    this.hkTihValue,
    this.status,
    this.statusNote,
    this.conductPrimarySchoolDataModel,
  });

  factory ConductPrimarySchoolModel.fromJson(Map<String, dynamic> json) =>
      _$ConductPrimarySchoolModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConductPrimarySchoolModelToJson(this);

  @override
  String toString() {
    return 'ConductPrimarySchoolModel{pupilId: $pupilId, learnYear: $learnYear, hocKy: $hocKy, hkTihValue: $hkTihValue, status: $status, statusNote: $statusNote, conductPrimarySchoolDataModel: $conductPrimarySchoolDataModel}';
  }

  ConductPrimarySchoolModel copyWith({
    String? pupilId,
    String? learnYear,
    String? hocKy,
    String? hkTihValue,
    String? status,
    String? statusNote,
    ConductPrimarySchoolDataModel? conductPrimarySchoolDataModel,
  }) {
    return ConductPrimarySchoolModel(
      pupilId: pupilId ?? this.pupilId,
      learnYear: learnYear ?? this.learnYear,
      hocKy: hocKy ?? this.hocKy,
      hkTihValue: hkTihValue ?? this.hkTihValue,
      status: status ?? this.status,
      statusNote: statusNote ?? this.statusNote,
      conductPrimarySchoolDataModel:
          conductPrimarySchoolDataModel ?? this.conductPrimarySchoolDataModel,
    );
  }
}
