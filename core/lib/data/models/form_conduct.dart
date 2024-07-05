class HanhKiemData {
  final String? status;
  final String? statusNote;
  final List<DataHanhKiemTih>? dataHanhKiemTih;
  final List<DataHanhKiemTih>? dataHanhKiem;
  final DataKeyTih? dataKeyTih;
  const HanhKiemData(
      {this.status,
      this.statusNote,
      this.dataHanhKiemTih,
      this.dataHanhKiem,
      this.dataKeyTih});
  HanhKiemData copyWith(
      {String? status,
      String? statusNote,
      List<DataHanhKiemTih>? dataHanhKiemTih,
      List<DataHanhKiemTih>? dataHanhKiem,
      DataKeyTih? dataKeyTih}) {
    return HanhKiemData(
        status: status ?? this.status,
        statusNote: statusNote ?? this.statusNote,
        dataHanhKiemTih: dataHanhKiemTih ?? this.dataHanhKiemTih,
        dataHanhKiem: dataHanhKiem ?? this.dataHanhKiem,
        dataKeyTih: dataKeyTih ?? this.dataKeyTih);
  }

  Map<String, Object?> toJson() {
    return {
      'status': status,
      'status_note': statusNote,
      'data_hanh_kiem_tih': dataHanhKiemTih
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'data_hanh_kiem': dataHanhKiem
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'data_key_tih': dataKeyTih?.toJson()
    };
  }

  static HanhKiemData fromJson(Map<String, Object?> json) {
    return HanhKiemData(
        status: json['status'] == null ? null : json['status'] as String,
        statusNote:
            json['status_note'] == null ? null : json['status_note'] as String,
        dataHanhKiemTih: json['data_hanh_kiem_tih'] == null
            ? null
            : (json['data_hanh_kiem_tih'] as List)
                .map<DataHanhKiemTih>((data) =>
                    DataHanhKiemTih.fromJson(data as Map<String, Object?>))
                .toList(),
        dataHanhKiem: json['data_hanh_kiem'] == null
            ? null
            : (json['data_hanh_kiem'] as List)
                .map<DataHanhKiemTih>((data) =>
                    DataHanhKiemTih.fromJson(data as Map<String, Object?>))
                .toList(),
        dataKeyTih: json['data_key_tih'] == null
            ? null
            : DataKeyTih.fromJson(
                json['data_key_tih'] as Map<String, Object?>));
  }

  @override
  String toString() {
    return '''HanhKiemData(
                status:$status,
statusNote:$statusNote,
dataHanhKiemTih:${dataHanhKiemTih.toString()},
dataHanhKiem:${dataHanhKiem.toString()},
dataKeyTih:${dataKeyTih.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is HanhKiemData &&
        other.runtimeType == runtimeType &&
        other.status == status &&
        other.statusNote == statusNote &&
        other.dataHanhKiemTih == dataHanhKiemTih &&
        other.dataHanhKiem == dataHanhKiem &&
        other.dataKeyTih == dataKeyTih;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, status, statusNote, dataHanhKiemTih,
        dataHanhKiem, dataKeyTih);
  }
}

class DataKeyTih {
  final NangLucCotLoiForm? nangLucCotLoi;
  final List<NangLucChung>? phamChatChuYeu;
  final List<NangLucChung>? nhanXetChungCuaGvcn;
  const DataKeyTih(
      {this.nangLucCotLoi, this.phamChatChuYeu, this.nhanXetChungCuaGvcn});
  DataKeyTih copyWith(
      {NangLucCotLoiForm? nangLucCotLoi,
      List<NangLucChung>? phamChatChuYeu,
      List<NangLucChung>? nhanXetChungCuaGvcn}) {
    return DataKeyTih(
        nangLucCotLoi: nangLucCotLoi ?? this.nangLucCotLoi,
        phamChatChuYeu: phamChatChuYeu ?? this.phamChatChuYeu,
        nhanXetChungCuaGvcn: nhanXetChungCuaGvcn ?? this.nhanXetChungCuaGvcn);
  }

  Map<String, Object?> toJson() {
    return {
      'nang_luc_cot_loi': nangLucCotLoi?.toJson(),
      'pham_chat_chu_yeu': phamChatChuYeu
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'nhan_xet_chung_cua_gvcn': nhanXetChungCuaGvcn
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList()
    };
  }

  static DataKeyTih fromJson(Map<String, Object?> json) {
    return DataKeyTih(
        nangLucCotLoi: json['nang_luc_cot_loi'] == null
            ? null
            : NangLucCotLoiForm.fromJson(
                json['nang_luc_cot_loi'] as Map<String, Object?>),
        phamChatChuYeu: json['pham_chat_chu_yeu'] == null
            ? null
            : (json['pham_chat_chu_yeu'] as List)
                .map<NangLucChung>((data) =>
                    NangLucChung.fromJson(data as Map<String, Object?>))
                .toList(),
        nhanXetChungCuaGvcn: json['nhan_xet_chung_cua_gvcn'] == null
            ? null
            : (json['nhan_xet_chung_cua_gvcn'] as List)
                .map<NangLucChung>((data) =>
                    NangLucChung.fromJson(data as Map<String, Object?>))
                .toList());
  }
}

class NangLucCotLoiForm {
  final List<NangLucChung>? nangLucChung;
  final List<NangLucChung>? nangLucDacThu;
  const NangLucCotLoiForm({this.nangLucChung, this.nangLucDacThu});
  NangLucCotLoiForm copyWith(
      {List<NangLucChung>? nangLucChung, List<NangLucChung>? nangLucDacThu}) {
    return NangLucCotLoiForm(
        nangLucChung: nangLucChung ?? this.nangLucChung,
        nangLucDacThu: nangLucDacThu ?? this.nangLucDacThu);
  }

  Map<String, Object?> toJson() {
    return {
      'nang_luc_chung': nangLucChung
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
      'nang_luc_dac_thu': nangLucDacThu
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList()
    };
  }

  static NangLucCotLoiForm fromJson(Map<String, Object?> json) {
    return NangLucCotLoiForm(
        nangLucChung: json['nang_luc_chung'] == null
            ? null
            : (json['nang_luc_chung'] as List)
                .map<NangLucChung>((data) =>
                    NangLucChung.fromJson(data as Map<String, Object?>))
                .toList(),
        nangLucDacThu: json['nang_luc_dac_thu'] == null
            ? null
            : (json['nang_luc_dac_thu'] as List)
                .map<NangLucChung>((data) =>
                    NangLucChung.fromJson(data as Map<String, Object?>))
                .toList());
  }
}

class NangLucChung {
  final String? hanhKiemKey;
  final String? hanhKiemName;
  const NangLucChung({this.hanhKiemKey, this.hanhKiemName});
  NangLucChung copyWith({String? hanhKiemKey, String? hanhKiemName}) {
    return NangLucChung(
        hanhKiemKey: hanhKiemKey ?? this.hanhKiemKey,
        hanhKiemName: hanhKiemName ?? this.hanhKiemName);
  }

  Map<String, Object?> toJson() {
    return {'hanh_kiem_key': hanhKiemKey, 'hanh_kiem_name': hanhKiemName};
  }

  static NangLucChung fromJson(Map<String, Object?> json) {
    return NangLucChung(
        hanhKiemKey: json['hanh_kiem_key'] == null
            ? null
            : json['hanh_kiem_key'] as String,
        hanhKiemName: json['hanh_kiem_name'] == null
            ? null
            : json['hanh_kiem_name'] as String);
  }
}

class DataHanhKiemTih {
  final String? hanhKiemValue;
  final String? hanhKiemName;
  const DataHanhKiemTih({this.hanhKiemValue, this.hanhKiemName});
  DataHanhKiemTih copyWith({String? hanhKiemValue, String? hanhKiemName}) {
    return DataHanhKiemTih(
        hanhKiemValue: hanhKiemValue ?? this.hanhKiemValue,
        hanhKiemName: hanhKiemName ?? this.hanhKiemName);
  }

  Map<String, Object?> toJson() {
    return {'hanh_kiem_value': hanhKiemValue, 'hanh_kiem_name': hanhKiemName};
  }

  static DataHanhKiemTih fromJson(Map<String, Object?> json) {
    return DataHanhKiemTih(
        hanhKiemValue: json['hanh_kiem_value'] == null
            ? null
            : json['hanh_kiem_value'] as String,
        hanhKiemName: json['hanh_kiem_name'] == null
            ? null
            : json['hanh_kiem_name'] as String);
  }
}
