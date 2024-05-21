import 'package:json_annotation/json_annotation.dart';
part 'menu_in_week_data_model.g.dart';

@JsonSerializable()
class MenuInWeekDataModel {
  @JsonKey(name: 'THUCDONTUAN_NGAY')
  final String? thucDonTuanNgay;
  @JsonKey(name: 'THUCDONTUAN_WEEK')
  final String? thucDonTuanWeek;
  @JsonKey(name: 'THUCDONTUAN_DATA_IN_WEEK')
  final List<MenuInWeekDataModelDetail>? thucDonTuanDataInWeek;

  MenuInWeekDataModel({
    this.thucDonTuanNgay,
    this.thucDonTuanWeek,
    this.thucDonTuanDataInWeek,
  });

  factory MenuInWeekDataModel.fromJson(Map<String, dynamic> json) =>
      _$MenuInWeekDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuInWeekDataModelToJson(this);

  @override
  String toString() {
    return 'MenuInWeekDataModel{thucDonTuanNgay: $thucDonTuanNgay, thucDonTuanWeek: $thucDonTuanWeek, thucDonTuanDataInWeek: $thucDonTuanDataInWeek}';
  }

  MenuInWeekDataModel copyWith({
    String? thucDonTuanNgay,
    String? thucDonTuanWeek,
    List<MenuInWeekDataModelDetail>? thucDonTuanDataInWeek,
  }) {
    return MenuInWeekDataModel(
      thucDonTuanNgay: thucDonTuanNgay ?? this.thucDonTuanNgay,
      thucDonTuanWeek: thucDonTuanWeek ?? this.thucDonTuanWeek,
      thucDonTuanDataInWeek:
          thucDonTuanDataInWeek ?? this.thucDonTuanDataInWeek,
    );
  }
}

@JsonSerializable()
class MenuInWeekDataModelDetail {
  @JsonKey(name: 'THUCDONTUAN_WEEK')
  final String? thucDonTuanWeek;
  @JsonKey(name: 'THUCDONTUAN_NGAY')
  final String? thucDonTuanNgay;
  @JsonKey(name: 'THUCDONTUAN_PICTURE')
  final String? thucDonTuanPicture;
  @JsonKey(name: 'THUCDONTUAN_TITLE')
  final String? thucDonTuanTitle;
  @JsonKey(name: 'THUCDONTUAN_CALO')
  final String? thucDonTuanCalo;
  @JsonKey(name: 'THUCDONTUAN_TYPE')
  final String? thucDonTuanType;
  @JsonKey(name: 'THUCDONTUAN_CATEGORY')
  final String? thucDonTuanCategory;

  MenuInWeekDataModelDetail({
    this.thucDonTuanWeek,
    this.thucDonTuanNgay,
    this.thucDonTuanPicture,
    this.thucDonTuanTitle,
    this.thucDonTuanCalo,
    this.thucDonTuanType,
    this.thucDonTuanCategory,
  });

  factory MenuInWeekDataModelDetail.fromJson(Map<String, dynamic> json) =>
      _$MenuInWeekDataModelDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MenuInWeekDataModelDetailToJson(this);

  @override
  String toString() {
    return 'MenuInWeekDataModelDetail{thucDonTuanWeek: $thucDonTuanWeek, thucDonTuanNgay: $thucDonTuanNgay, thucDonTuanPicture: $thucDonTuanPicture, thucDonTuanTitle: $thucDonTuanTitle, thucDonTuanCalo: $thucDonTuanCalo, thucDonTuanType: $thucDonTuanType, thucDonTuanCategory: $thucDonTuanCategory}';
  }

  MenuInWeekDataModelDetail copyWith({
    String? thucDonTuanWeek,
    String? thucDonTuanNgay,
    String? thucDonTuanPicture,
    String? thucDonTuanTitle,
    String? thucDonTuanCalo,
    String? thucDonTuanType,
    String? thucDonTuanCategory,
  }) {
    return MenuInWeekDataModelDetail(
      thucDonTuanWeek: thucDonTuanWeek ?? this.thucDonTuanWeek,
      thucDonTuanNgay: thucDonTuanNgay ?? this.thucDonTuanNgay,
      thucDonTuanPicture: thucDonTuanPicture ?? this.thucDonTuanPicture,
      thucDonTuanTitle: thucDonTuanTitle ?? this.thucDonTuanTitle,
      thucDonTuanCalo: thucDonTuanCalo ?? this.thucDonTuanCalo,
      thucDonTuanType: thucDonTuanType ?? this.thucDonTuanType,
      thucDonTuanCategory: thucDonTuanCategory ?? this.thucDonTuanCategory,
    );
  }
}
