import 'package:hive_flutter/hive_flutter.dart';

class AdministrativeResponse {
  List<Province>? provinces;

  AdministrativeResponse({this.provinces});

  AdministrativeResponse.fromJson(Map<String, dynamic> json) {
    if (json['provinces'] != null) {
      provinces = [];
      json['provinces'].forEach((v) {
        provinces!.add(Province.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Province {
  String? code;
  String? name;
  String? country_code;
  List<District>? districts;

  Province({this.code, this.name, this.country_code, this.districts});

  Province.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    country_code = json['country_code'];
    if (json['districts'] != null) {
      districts = <District>[];
      json['districts'].forEach((v) {
        districts?.add(District.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    data['country_code'] = country_code;
    if (districts != null) {
      data['districts'] = districts?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '$code - ${districts.toString()}';
  }
}

class District {
  String? code;
  String? name;
  List<Ward>? wards;

  District({this.code, this.name, this.wards});

  District.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['wards'] != null) {
      wards = <Ward>[];
      json['wards'].forEach((v) {
        wards?.add(Ward.fromJson(v.cast<String, String>()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    if (wards != null) {
      data['wards'] = wards?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '${code ?? 'null'} - ${name ?? 'null'}';
  }
}

class Ward {
  String? code;
  String? name;

  Ward({this.code, this.name});

  Ward.fromJson(Map<String, String> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return '${code ?? 'null'} - ${name ?? 'null'}';
  }
}

class ProvinceAdapter extends TypeAdapter<Province> {
  @override
  final int typeId = 1;

  @override
  Province read(BinaryReader reader) {
    final province = Province()
      ..code = reader.readString()
      ..name = reader.readString()
      ..country_code = reader.readString();
    final lengthDistrict = reader.readUint32();
    if (lengthDistrict > 0) {
      province.districts = [];
      for (var i = 0; i < lengthDistrict; i++) {
        final district = reader.readMap().cast<String, dynamic>();
        province.districts!.add(District.fromJson(district));
      }
    }
    return province;
  }

  @override
  void write(BinaryWriter writer, Province obj) {
    writer
      ..writeString(obj.code ?? '')
      ..writeString(obj.name ?? '')
      ..writeString(obj.country_code ?? '')
      ..writeUint32(obj.districts?.length ?? 0);
    if (obj.districts?.isNotEmpty == true) {
      for (final district in obj.districts!) {
        writer.writeMap(district.toJson());
      }
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProvinceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
