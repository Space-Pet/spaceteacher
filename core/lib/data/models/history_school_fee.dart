import 'package:freezed_annotation/freezed_annotation.dart';

import 'history_school_fee_item.dart';

part 'history_school_fee.g.dart';

@JsonSerializable(explicitToJson: true)
class HistorySchoolFee {
  @JsonKey(name: 'items')
  final List<HistorySchoolFeeItem>? historySchoolFeeItems;

  HistorySchoolFee({
    this.historySchoolFeeItems,
  });

  factory HistorySchoolFee.fromJson(Map<String, dynamic> json) =>
      _$HistorySchoolFeeFromJson(json);

  Map<String, dynamic> toJson() => _$HistorySchoolFeeToJson(this);

  @override
  String toString() =>
      'HistorySchoolFee(historySchoolFeeItems: $historySchoolFeeItems)';

  HistorySchoolFee copyWith({
    List<HistorySchoolFeeItem>? historySchoolFeeItems,
  }) {
    return HistorySchoolFee(
      historySchoolFeeItems:
          historySchoolFeeItems ?? this.historySchoolFeeItems,
    );
  }
}
