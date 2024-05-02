import 'dart:convert';

class PrimaryConduct {
  String learnYear;
  String txtHocKy;
  String hkTihValue;
  ConductData data;

  PrimaryConduct({
    required this.learnYear,
    required this.txtHocKy,
    required this.hkTihValue,
    required this.data,
  });

  factory PrimaryConduct.fromMap(Map<String, dynamic> map) {
    return PrimaryConduct(
      learnYear: map['learn_year'],
      txtHocKy: map['txt_hoc_ky'],
      hkTihValue: map['hk_tih_value'],
      data: ConductData.fromMap(map['data']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'learn_year': learnYear,
      'txt_hoc_ky': txtHocKy,
      'hk_tih_value': hkTihValue,
      'data': data.toMap(),
    };
  }

  factory PrimaryConduct.fromJson(String json) {
    return PrimaryConduct.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory PrimaryConduct.empty() {
    return PrimaryConduct(
      learnYear: '2023-2024',
      txtHocKy: '1',
      hkTihValue: '1',
      data: ConductData(
        nangLucCotLoi: NangLucCotLoi(
          nangLucChung: [],
          nangLucDacThu: [],
        ),
        phamChatChuYeu: [],
        nhanXetChungCuaGvcn: [],
      ),
    );
  }
}

class ConductData {
  NangLucCotLoi nangLucCotLoi;
  List<ConductItem> phamChatChuYeu;
  List<ConductItem> nhanXetChungCuaGvcn;

  ConductData({
    required this.nangLucCotLoi,
    required this.phamChatChuYeu,
    required this.nhanXetChungCuaGvcn,
  });

  factory ConductData.fromMap(Map<String, dynamic> map) {
    return ConductData(
      nangLucCotLoi: NangLucCotLoi.fromMap(map['nang_luc_cot_loi']),
      phamChatChuYeu: List<ConductItem>.from(
          map['pham_chat_chu_yeu']?.map((x) => ConductItem.fromMap(x))),
      nhanXetChungCuaGvcn: List<ConductItem>.from(
          map['nhan_xet_chung_cua_gvcn']?.map((x) => ConductItem.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nang_luc_cot_loi': nangLucCotLoi.toMap(),
      'pham_chat_chu_yeu': phamChatChuYeu.map((x) => x.toMap()).toList(),
      'nhan_xet_chung_cua_gvcn':
          nhanXetChungCuaGvcn.map((x) => x.toMap()).toList(),
    };
  }

  factory ConductData.fromJson(String json) {
    return ConductData.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class NangLucCotLoi {
  List<ConductItem> nangLucChung;
  List<ConductItem> nangLucDacThu;

  NangLucCotLoi({
    required this.nangLucChung,
    required this.nangLucDacThu,
  });

  factory NangLucCotLoi.fromMap(Map<String, dynamic> map) {
    return NangLucCotLoi(
      nangLucChung: List<ConductItem>.from(
          map['nang_luc_chung']?.map((x) => ConductItem.fromMap(x))),
      nangLucDacThu: List<ConductItem>.from(
          map['nang_luc_dac_thu']?.map((x) => ConductItem.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nang_luc_chung': nangLucChung.map((x) => x.toMap()).toList(),
      'nang_luc_dac_thu': nangLucDacThu.map((x) => x.toMap()).toList(),
    };
  }

  factory NangLucCotLoi.fromJson(String json) {
    return NangLucCotLoi.fromMap(jsonDecode(json));
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}

class ConductItem {
  String hanhKiemKey;
  String hanhKiemName;
  String hanhKiemValue;

  ConductItem({
    required this.hanhKiemKey,
    required this.hanhKiemName,
    required this.hanhKiemValue,
  });

  factory ConductItem.fromMap(Map<String, dynamic> map) {
    return ConductItem(
      hanhKiemKey: map['hanh_kiem_key'],
      hanhKiemName: map['hanh_kiem_name'],
      hanhKiemValue: map['hanh_kiem_value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hanh_kiem_key': hanhKiemKey,
      'hanh_kiem_name': hanhKiemName,
      'hanh_kiem_value': hanhKiemValue,
    };
  }
}
