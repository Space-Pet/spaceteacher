class Menu {
  final String txtCurrentWeek;
  final String txtWeek;
  final String txtEndDay;
  final String txtBeginDay;
  final String txtPreWeek;
  final String txtNexrWeek;
  final List<DataMenu> data;
  const Menu({
    this.data = const [],
    this.txtCurrentWeek = '',
    this.txtWeek = '',
    this.txtEndDay = '',
    this.txtBeginDay = '',
    this.txtPreWeek = '',
    this.txtNexrWeek = '',
  });
  factory Menu.fromJson(Map<String, dynamic> json) {
    final data = <DataMenu>[];
    final jsonData = json['data'] as List? ?? [];
    if (jsonData.isNotEmpty) {
      for (final element in jsonData) {
        final parcer = DataMenu.fromJson(element);
        if (parcer.isNotEmpty) {
          data.add(parcer);
        }
      }
    }
    return Menu(
        data: data,
        txtCurrentWeek: json['txt_current_week'] ?? '',
        txtEndDay: json['txt_end_day'] ?? '',
        txtNexrWeek: json['txt_next_week'] ?? '',
        txtBeginDay: json['txt_begin_day'] ?? '',
        txtPreWeek: json['txt_pre_week'] ?? '',
        txtWeek: json['txt_week'] ?? '');
  }
  factory Menu.empty() => const Menu();
}

class DataMenu {
  final String thucDonNgay;
  final String thucDonNgayWeek;
  final List<DataInWeek> dataInWeek;
  const DataMenu(
      {required this.dataInWeek,
      required this.thucDonNgay,
      required this.thucDonNgayWeek});
  factory DataMenu.fromJson(Map<String, dynamic> json) {
    final dataInWeek = <DataInWeek>[];
    final list = json['THUCDONTUAN_DATA_IN_WEEK'] as List? ?? [];
    if (list.isNotEmpty) {
      for (final element in list) {
        final parcer = DataInWeek.fromJson(element);
        if (parcer != null) {
          dataInWeek.add(parcer);
        }
      }
    }
    return DataMenu(
      dataInWeek: dataInWeek,
      thucDonNgay: json['THUCDONTUAN_NGAY'] ?? '',
      thucDonNgayWeek: json['THUCDONTUAN_WEEK'] ?? '',
    );
  }
  factory DataMenu.empty() {
    return const DataMenu(dataInWeek: [], thucDonNgay: '', thucDonNgayWeek: '');
  }

  bool get isEmpty =>
      dataInWeek.isEmpty && thucDonNgay.isEmpty && thucDonNgayWeek.isEmpty;

  bool get isNotEmpty =>
      dataInWeek.isNotEmpty ||
      thucDonNgay.isNotEmpty ||
      thucDonNgayWeek.isNotEmpty;
}

class DataInWeek {
  final String title;
  final String category;
  final String picture;
  const DataInWeek(
      {required this.category, required this.picture, required this.title});
  static DataInWeek? fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return DataInWeek(
          category: json['THUCDONTUAN_CATEGORY'] ?? '',
          picture: json['THUCDONTUAN_PICTURE'] ?? '',
          title: json['THUCDONTUAN_TITLE'] ?? '');
    }
    return null;
  }
}
