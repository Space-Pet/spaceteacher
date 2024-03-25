import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/iterables.dart';

import '../../common/utils.dart';
import '../../di/di.dart';
import '../data_source/local/local_data_manager.dart';

part 'voucher.g.dart';

@JsonSerializable(explicitToJson: true)
class Voucher {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'expired_at')
  DateTime? expiredAt;

  @JsonKey(name: 'effective_at')
  DateTime? effectiveAt;

  @JsonKey(name: 'quota')
  int? quota;

  @JsonKey(name: 'quota_per_user')
  int? quotaPerUser;

  @JsonKey(name: 'order_min_amount')
  int? orderMinAmount;

  @JsonKey(name: 'value')
  num? value;

  @JsonKey(name: 'value_max')
  int? valueMax;

  @JsonKey(name: 'fixed')
  bool? fixed;

  @JsonKey(name: 'type')
  bool? type;

  @JsonKey(name: 'used_count')
  int? usedCount;

  @JsonKey(name: 'user_used_count')
  int? userUsedCount;

  @JsonKey(name: 'icon_url')
  String? iconUrl;

  @JsonKey(name: 'thumbnail_url')
  String? thumbnailUrl;

  @JsonKey(name: 'service_id')
  String? serviceId;

  @JsonKey(name: 'new_user')
  bool? newUser;

  @JsonKey(name: 'promotion_name')
  Content? promotionName;

  @JsonKey(name: 'promotion_description')
  Content? promotionDescription;

  Voucher({
    this.name,
    this.description,
    this.expiredAt,
    this.effectiveAt,
    this.quota,
    this.quotaPerUser,
    this.orderMinAmount,
    this.value,
    this.valueMax,
    this.fixed,
    this.type,
    this.usedCount,
    this.userUsedCount,
    this.serviceId,
    this.id,
    this.iconUrl,
    this.thumbnailUrl,
    this.newUser,
    this.promotionName,
    this.promotionDescription,
  });
  // Lấy điều kiện sử dụng voucher
  bool get getConditionVoucher {
    return userUsedCount! >= quotaPerUser! || usedCount! >= quota!;
  }

  String? get getName {
    final locale = injector.get<LocalDataManager>().getLocalization();
    return promotionName?.toJson()[locale ?? 'vi'];
  }

  String? get getDescription {
    final locale = injector.get<LocalDataManager>().getLocalization();
    return promotionDescription?.toJson()[locale ?? 'vi'];
  }

  String? get expiredDateAsString => expiredAt?.serverToDateTimeFull();

  int? get remainingDays => expiredAt?.difference(DateTime.now()).inDays;

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Content {
  String? en;
  String? vi;

  Content({this.en, this.vi});

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

extension ListVoucher on List<Voucher> {
  int get orderMinAmount {
    final result = max<Voucher>(this, (a, b) {
      if ((a.orderMinAmount ?? 0) > (b.orderMinAmount ?? 0)) {
        return 1;
      } else if ((a.orderMinAmount ?? 0) < (b.orderMinAmount ?? 0)) {
        return -1;
      }
      return 0;
    });
    return result?.orderMinAmount ?? 0;
  }

    int get valueMax {
    final result = max<Voucher>(this, (a, b) {
      if ((a.valueMax ?? 0) > (b.valueMax ?? 0)) {
        return 1;
      } else if ((a.valueMax ?? 0) < (b.valueMax ?? 0)) {
        return -1;
      }
      return 0;
    });
    return result?.valueMax ?? 0;
  }
  num get value {
    final result = max<Voucher>(this, (a, b) {
      if ((a.value ?? 0) > (b.value ?? 0)) {
        return 1;
      } else if ((a.value ?? 0) < (b.value ?? 0)) {
        return -1;
      }
      return 0;
    });
    return result?.value ?? 0;
  }
  // List<BookingPromotion> get bookingPromotions {
  //   return map((e) => BookingPromotion(
  //         amount:  double.tryParse('${e.promotionDescription}'),
  //         promotionId: e.id,
  //       )).toList();
  // }
}
