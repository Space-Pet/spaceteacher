import 'package:json_annotation/json_annotation.dart';

part 'student_fees.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentFeesResponse {
  final String? status;
  final String? message;
  final int? code;
  final _Data? data;

  StudentFeesResponse({
    this.status,
    this.message,
    this.code,
    this.data,
  });

  factory StudentFeesResponse.fromJson(Map<String, dynamic> json) =>
      _$StudentFeesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StudentFeesResponseToJson(this);

  StudentFeesResponse copyWith({
    String? status,
    String? message,
    int? code,
    _Data? data,
  }) {
    return StudentFeesResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'StudentFeesResponse(status: $status, message: $message, code: $code, data: $data)';
  }
}

@JsonSerializable(explicitToJson: true)
class _Data {
  @JsonKey(name: 'SP1_001')
  final FeeCategory? sp1_001;
  @JsonKey(name: 'SP1_002')
  final FeeCategory? sp1_002;
  @JsonKey(name: 'SP1_003')
  final FeeCategory? sp1_003;
  @JsonKey(name: 'SP1_004')
  final FeeCategory? sp1_004;
  @JsonKey(name: 'SP1_005')
  final FeeCategory? sp1_005;

  _Data({
    this.sp1_001,
    this.sp1_002,
    this.sp1_003,
    this.sp1_004,
    this.sp1_005,
  });

  factory _Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  _Data copyWith({
    FeeCategory? sp1_001,
    FeeCategory? sp1_002,
    FeeCategory? sp1_003,
    FeeCategory? sp1_004,
    FeeCategory? sp1_005,
  }) {
    return _Data(
      sp1_001: sp1_001 ?? this.sp1_001,
      sp1_002: sp1_002 ?? this.sp1_002,
      sp1_003: sp1_003 ?? this.sp1_003,
      sp1_004: sp1_004 ?? this.sp1_004,
      sp1_005: sp1_005 ?? this.sp1_005,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class FeeCategory {
  final FeeCategoryData? data;

  FeeCategory({
    this.data,
  });

  factory FeeCategory.fromJson(Map<String, dynamic> json) =>
      _$FeeCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FeeCategoryToJson(this);

  FeeCategory copyWith({
    FeeCategoryData? data,
  }) {
    return FeeCategory(
      data: data ?? this.data,
    );
  }

  @override
  String toString() {
    return 'FeeCategory(data: $data)';
  }
}

@JsonSerializable(explicitToJson: true)
class FeeCategoryData {
  final String? title;
  final int? multiple_choice;
  final List<FeeItem>? items;

  FeeCategoryData({
    this.title,
    this.multiple_choice,
    this.items,
  });

  factory FeeCategoryData.fromJson(Map<String, dynamic> json) =>
      _$FeeCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$FeeCategoryDataToJson(this);

  FeeCategoryData copyWith({
    String? title,
    int? multiple_choice,
    List<FeeItem>? items,
  }) {
    return FeeCategoryData(
      title: title ?? this.title,
      multiple_choice: multiple_choice ?? this.multiple_choice,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'FeeCategoryData(title: $title, multiple_choice: $multiple_choice, items: $items)';
  }
}

@JsonSerializable(explicitToJson: true)
class FeeItem {
  final int? id;
  final int? list_fee_id;
  final int? list_fee_detail_id;
  final int? school_id;
  final String? learn_year;
  final String? title;
  final String? content;
  @JsonKey(fromJson: _priceFromJson, toJson: _priceToJson)
  final int price;
  final String? level;
  final int? apply_multiple;
  final String? unit;
  final bool? active;
  final String? SPL1_Ma;
  final String? SPL1_Ten;
  final String? SPL2_Ma;
  final String? SPL2_Ten;
  final String? SPL3_Ma;
  final String? SPL3_Ten;
  final String? PB_11T_GROUP;
  final MetaData? meta_data;
  final String? date;
  final int? discount;

  final int? grand_total;
  final String? status;

  FeeItem({
    this.id,
    this.list_fee_id,
    this.list_fee_detail_id,
    this.school_id,
    this.learn_year,
    this.title,
    this.content,
    this.price = 0,
    this.level,
    this.apply_multiple,
    this.unit,
    this.active,
    this.SPL1_Ma,
    this.SPL1_Ten,
    this.SPL2_Ma,
    this.SPL2_Ten,
    this.SPL3_Ma,
    this.SPL3_Ten,
    this.PB_11T_GROUP,
    this.meta_data,
    this.date,
    this.discount,
    this.grand_total,
    this.status,
  });

  factory FeeItem.fromJson(Map<String, dynamic> json) =>
      _$FeeItemFromJson(json);
  Map<String, dynamic> toJson() => _$FeeItemToJson(this);

  static int _priceFromJson(dynamic price) {
    if (price is int) {
      return price;
    } else if (price is String) {
      return int.tryParse(price) ?? 0;
    } else {
      throw Exception('Invalid type for price');
    }
  }

  static dynamic _priceToJson(int price) => price;

  FeeItem copyWith({
    int? id,
    int? list_fee_id,
    int? list_fee_detail_id,
    int? school_id,
    String? learn_year,
    String? title,
    String? content,
    int? price,
    String? level,
    int? apply_multiple,
    String? unit,
    bool? active,
    String? SPL1_Ma,
    String? SPL1_Ten,
    String? SPL2_Ma,
    String? SPL2_Ten,
    String? SPL3_Ma,
    String? SPL3_Ten,
    String? PB_11T_GROUP,
    MetaData? meta_data,
    String? date,
    int? discount,
    int? grand_total,
    String? status,
  }) {
    return FeeItem(
      id: id ?? this.id,
      list_fee_id: list_fee_id ?? this.list_fee_id,
      list_fee_detail_id: list_fee_detail_id ?? this.list_fee_detail_id,
      school_id: school_id ?? this.school_id,
      learn_year: learn_year ?? this.learn_year,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      level: level ?? this.level,
      apply_multiple: apply_multiple ?? this.apply_multiple,
      unit: unit ?? this.unit,
      active: active ?? this.active,
      SPL1_Ma: SPL1_Ma ?? this.SPL1_Ma,
      SPL1_Ten: SPL1_Ten ?? this.SPL1_Ten,
      SPL2_Ma: SPL2_Ma ?? this.SPL2_Ma,
      SPL2_Ten: SPL2_Ten ?? this.SPL2_Ten,
      SPL3_Ma: SPL3_Ma ?? this.SPL3_Ma,
      SPL3_Ten: SPL3_Ten ?? this.SPL3_Ten,
      PB_11T_GROUP: PB_11T_GROUP ?? this.PB_11T_GROUP,
      meta_data: meta_data ?? this.meta_data,
      date: date ?? this.date,
      discount: discount ?? this.discount,
      grand_total: grand_total ?? this.grand_total,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'FeeItem(id: $id, list_fee_id: $list_fee_id, list_fee_detail_id: $list_fee_detail_id ,school_id: $school_id, learn_year: $learn_year, title: $title, content: $content, price: $price, level: $level, apply_multiple: $apply_multiple, unit: $unit, active: $active, SPL1_Ma: $SPL1_Ma, SPL1_Ten: $SPL1_Ten, SPL2_Ma: $SPL2_Ma, SPL2_Ten: $SPL2_Ten, SPL3_Ma: $SPL3_Ma, SPL3_Ten: $SPL3_Ten, PB_11T_GROUP: $PB_11T_GROUP, meta_data: $meta_data, date: $date, discount: $discount, grand_total: $grand_total, status: $status)';
  }
}

@JsonSerializable(explicitToJson: true)
class MetaData {
  final MetaDataPrice? price;
  final List<MetaDataItem>? items;

  MetaData({
    this.price,
    this.items,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MetaDataPrice {
  final String? label;
  final String? price_text;

  MetaDataPrice({
    this.label,
    this.price_text,
  });

  factory MetaDataPrice.fromJson(Map<String, dynamic> json) =>
      _$MetaDataPriceFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataPriceToJson(this);

  MetaDataPrice copyWith({
    String? label,
    String? price_text,
  }) {
    return MetaDataPrice(
      label: label ?? this.label,
      price_text: price_text ?? this.price_text,
    );
  }

  @override
  String toString() {
    return 'MetaDataPrice(label: $label, price_text: $price_text)';
  }
}

@JsonSerializable()
class MetaDataItem {
  final int? list_fee_detail_id;
  final String? price;
  final String? label;
  final String? date;

  MetaDataItem({
    this.list_fee_detail_id,
    this.price,
    this.label,
    this.date,
  });

  factory MetaDataItem.fromJson(Map<String, dynamic> json) =>
      _$MetaDataItemFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataItemToJson(this);

  MetaDataItem copyWith({
    int? list_fee_detail_id,
    String? price,
    String? label,
    String? date,
  }) {
    return MetaDataItem(
      list_fee_detail_id: list_fee_detail_id ?? this.list_fee_detail_id,
      price: price ?? this.price,
      label: label ?? this.label,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'MetaDataItem(list_fee_detail_id: $list_fee_detail_id, price: $price, label: $label, date: $date)';
  }
}
