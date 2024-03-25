import 'package:json_annotation/json_annotation.dart';

part 'convenience_store.g.dart';

@JsonSerializable(explicitToJson: true)
class ConvenienceStore {
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'contact_number')
  String? contactNumber;
  @JsonKey(name: 'logo_url')
  String? logoUrl;
  String? name;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'ward_name')
  String? wardName;
  String? street;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'ward_code')
  String? wardCode;
  String? id;
  @JsonKey(name: 'province_code')
  String? provinceCode;
  @JsonKey(name: 'district_code')
  String? districtCode;
  double? distance;

  ConvenienceStore({
    this.contactName,
    this.contactNumber,
    this.logoUrl,
    this.name,
    this.provinceName,
    this.wardName,
    this.street,
    this.districtName,
    this.wardCode,
    this.provinceCode,
    this.districtCode,
    this.distance,
    this.id,
  });

  String get fullAddressDescription {
    return [street, wardName, districtName, provinceName]
        .where((element) => element != null && element.isNotEmpty == true)
        .join(', ');
  }

  factory ConvenienceStore.fromJson(Map<String, dynamic> json) =>
      _$ConvenienceStoreFromJson(json);

  Map<String, dynamic> toJson() => _$ConvenienceStoreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConvenienceStoreMaterial {
  MaterialItem? material;
  int? quantity;

  ConvenienceStoreMaterial({this.material, this.quantity});

  factory ConvenienceStoreMaterial.fromJson(Map<String, dynamic> json) =>
      _$ConvenienceStoreMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$ConvenienceStoreMaterialToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MaterialItem {
  String? name;
  Unit? unit;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  String? id;
  double? price;

  MaterialItem({this.name, this.unit, this.imageUrl});

  factory MaterialItem.fromJson(Map<String, dynamic> json) =>
      _$MaterialItemFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Unit {
  Description? description;
  String? id;

  Unit({this.description, this.id});

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  Map<String, dynamic> toJson() => _$UnitToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Description {
  String? en;
  String? vi;

  Description({this.en, this.vi});

  factory Description.fromJson(Map<String, dynamic> json) =>
      _$DescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$DescriptionToJson(this);
}
