import 'package:json_annotation/json_annotation.dart';

import 'school_fee_item.dart';

part 'school_fee.g.dart';

@JsonSerializable(explicitToJson: true)
class SchoolFee {
  @JsonKey(name: 'items')
  final List<SchoolFeeItem>? schoolFeeItems;
  final int? totalThanhTien;
  final int? totalDaDong;
  final int? totalChuaNop;
  final String? totalCanTru;

  SchoolFee({
    this.schoolFeeItems,
    this.totalThanhTien,
    this.totalDaDong,
    this.totalChuaNop,
    this.totalCanTru,
  });

  factory SchoolFee.fromJson(Map<String, dynamic> json) =>
      _$SchoolFeeFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolFeeToJson(this);

  @override
  String toString() {
    return 'SchoolFee(schoolFeeItems: $schoolFeeItems, totalThanhTien: $totalThanhTien, totalDaDong: $totalDaDong, totalChuaNop: $totalChuaNop, totalCanTru: $totalCanTru)';
  }

  SchoolFee copyWith({
    List<SchoolFeeItem>? schoolFeeItems,
    int? totalThanhTien,
    int? totalDaDong,
    int? totalChuaNop,
    String? totalCanTru,
  }) {
    return SchoolFee(
      schoolFeeItems: schoolFeeItems ?? this.schoolFeeItems,
      totalThanhTien: totalThanhTien ?? this.totalThanhTien,
      totalDaDong: totalDaDong ?? this.totalDaDong,
      totalChuaNop: totalChuaNop ?? this.totalChuaNop,
      totalCanTru: totalCanTru ?? this.totalCanTru,
    );
  }
}
