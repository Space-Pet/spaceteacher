import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../common/constants.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  Service(
      {this.id,
      this.detailedDescription,
      this.contents,
      this.iconUrl,
      this.locations,
      this.workingDays,
      this.commitments,
      this.additionalServices,
      this.serviceCharge,
      this.currencyCode,
      this.serviceItems,
      this.metadata,
      this.limitDayBooking,
      this.serviceTools});

  bool get isRepairsService =>
      id == ServiceType.repairs || id == ServiceType.electricalRefrigeration;

  bool get isCleaningService =>  id == ServiceType.cleaning;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  @JsonKey(name: 'additional_services')
  List<AdditionalServices>? additionalServices;

  List<Commitments>? commitments;
  List<Contents>? contents;
  @JsonKey(name: 'currency_code')
  String? currencyCode;

  @JsonKey(name: 'icon_url')
  String? iconUrl;

  String? id;
  @JsonKey(name: 'detailed_description')
  String? detailedDescription;
  List<String>? locations;
  Metadata? metadata;
  @JsonKey(name: 'service_charge')
  int? serviceCharge;

  @JsonKey(name: 'service_items')
  List<ServiceItems>? serviceItems;

  @JsonKey(name: 'working_days')
  List<int>? workingDays;

  @JsonKey(name: 'limit_day_booking')
  int? limitDayBooking;

  @JsonKey(name: 'service_tools')
  List<ServiceTools>? serviceTools;

  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}

@JsonSerializable()
class Contents extends Equatable {
  Contents({
    this.language,
    this.name = '--',
    this.description,
    this.slug,
  });

  factory Contents.fromJson(Map<String, dynamic> json) =>
      _$ContentsFromJson(json);

  final String? description;
  final String? language;
  @JsonKey(defaultValue: '--')
  final String name;
  final String? slug;

  Map<String, dynamic> toJson() => _$ContentsToJson(this);

  factory Contents.empty() => Contents();

  bool get isEmpty => this == Contents.empty();
  bool get isNotEmpty => !isEmpty;
  
  @override
  List<Object?> get props => [description,language,name,slug];
}

@JsonSerializable()
class Name {
  Name({this.vi, this.en});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  String? en;
  String? vi;

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

@JsonSerializable()
class Commitments {
  Commitments({this.commitment});

  factory Commitments.fromJson(Map<String, dynamic> json) =>
      _$CommitmentsFromJson(json);

  Commitment? commitment;

  Map<String, dynamic> toJson() => _$CommitmentsToJson(this);
}

@JsonSerializable()
class Commitment {
  Commitment({this.iconUrl, this.name, this.description});

  factory Commitment.fromJson(Map<String, dynamic> json) =>
      _$CommitmentFromJson(json);

  Name? description;
  @JsonKey(name: 'icon_url')
  String? iconUrl;

  Name? name;

  Map<String, dynamic> toJson() => _$CommitmentToJson(this);
}

@JsonSerializable()
class AdditionalServices {
  AdditionalServices({
    this.additionalService,
    this.quantity,
  });

  factory AdditionalServices.fromJson(Map<String, dynamic> json) =>
      _$AdditionalServicesFromJson(json);

  @JsonKey(name: 'additional_service')
  AdditionalService? additionalService;

  int? quantity;

  num get totalHours {
    return (quantity ?? 0) * (additionalService?.timeUnit ?? 0);
  }

  Map<String, dynamic> toJson() => _$AdditionalServicesToJson(this);
}

@JsonSerializable()
class AdditionalService {
  AdditionalService({
    this.id,
    this.iconUrl,
    this.name,
    this.description,
    this.cost,
    this.currencyCode,
    this.timeUnit,
    this.disabled,
    this.costOnly
  });

  factory AdditionalService.fromJson(Map<String, dynamic> json) =>
      _$AdditionalServiceFromJson(json);

  int? cost;
  @JsonKey(name: 'currency_code')
  String? currencyCode;

  Name? description;
  bool? disabled;
  @JsonKey(name: 'icon_url')
  String? iconUrl;

  String? id;
  Name? name;
  @JsonKey(name: 'time_unit')
  int? timeUnit;
  @JsonKey(name: 'cost_only')
  bool? costOnly;
int get totalCost {
    return (timeUnit ?? 0) * (cost ?? 0);
  }
  Map<String, dynamic> toJson() => _$AdditionalServiceToJson(this);
}

@JsonSerializable()
class ServiceItems {
  ServiceItems({
    this.id,
    this.name,
    this.workingTime,
    this.description,
    this.avatarUrl,
    this.value,
    this.type,
    this.price,
    this.effectiveDate,
    this.expiredDate,
    this.timeFrame,
    this.percent_price,
    this.totalPriceOfSurcharge = 0,
  });

  factory ServiceItems.fromJson(Map<String, dynamic> json) =>
      _$ServiceItemsFromJson(json);

  String? id;
  Name? name;
  String? type;
  @JsonKey(name: 'working_time')
  int? workingTime;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;
  Name? description;
  double? value;
  double? price;
  @JsonKey(name: 'effective_date')
  String? effectiveDate;
  @JsonKey(name: 'expired_date')
  String? expiredDate;
  @JsonKey(name: 'time_frame')
  String? timeFrame;
  @JsonKey(name: 'percent_price')
  String? percent_price;

  @JsonKey(includeFromJson: false, includeToJson: false)
  double totalPriceOfSurcharge; 

  Map<String, dynamic> toJson() => _$ServiceItemsToJson(this);
}

@JsonSerializable()
class Metadata {
  Metadata({
    this.minStartHour,
    this.maxWorkingHour,
    this.costNotice,
    this.cancelStatus,
    this.maxBooking,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  @JsonKey(name: 'cancel_status')
  List<String>? cancelStatus;

  @JsonKey(name: 'cost_notice')
  String? costNotice;

  @JsonKey(name: 'max_booking')
  String? maxBooking;

  @JsonKey(name: 'max_working_hour')
  String? maxWorkingHour;

  @JsonKey(name: 'min_start_hour')
  String? minStartHour;

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class ServiceTools {
  ServiceTools({
    this.id,
    this.name,
    this.image,
  });

  String? id;
  String? name;
  String? image;

  factory ServiceTools.fromJson(Map<String, dynamic> json) =>
      _$ServiceToolsFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToolsToJson(this);
}

@JsonSerializable()
class BookingSurcharge {
  BookingSurcharge({
    this.serviceItemPrice,
    this.priceSurcharge,
    this.surcharge,
  });
  @JsonKey(name: 'service_item_price')
  double? serviceItemPrice;
  @JsonKey(name: 'price_surcharge')
  double? priceSurcharge;
  @JsonKey(name: 'service_item')
  ServiceItems? surcharge;

  factory BookingSurcharge.fromJson(Map<String, dynamic> json) =>
      _$BookingSurchargeFromJson(json);
  Map<String, dynamic> toJson() => _$BookingSurchargeToJson(this);
}
