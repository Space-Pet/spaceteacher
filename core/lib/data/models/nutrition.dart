
class Nutrition {
  final String statusNote;
  final List<DataNutrition> dataNutrition;
  const Nutrition({required this.dataNutrition, required this.statusNote});
  factory Nutrition.fromJson(Map<String, dynamic> json) {
    final dataNutrition = (json['data'] as List<dynamic>?)
        ?.map((e) => DataNutrition.fromJson(e))
        .toList();
    return Nutrition(
        dataNutrition: dataNutrition ?? [],
        statusNote: json['status_note'] ?? '');
  }
}

class DataNutrition {
  final String month;
  final String currentMonth;
  final String height;
  final String weight;
  final double bmi;
  final int monthsAgeCurrent;
  final int ageCurrent;
  final String gender;
  final String ketLuan;
  const DataNutrition(
      {required this.ageCurrent,
      required this.bmi,
      required this.currentMonth,
      required this.gender,
      required this.height,
      required this.ketLuan,
      required this.month,
      required this.monthsAgeCurrent,
      required this.weight});
  factory DataNutrition.fromJson(Map<String, dynamic> json) {
    return DataNutrition(
      ageCurrent: json['age_current'] != null
          ? int.parse(json['age_current'].toString())
          : 0,
      bmi: json['Bmi'] != null ? double.parse(json['Bmi'].toString()) : 0,
      currentMonth:
          json['current_month'] != null ? json['current_month'].toString() : '',
      gender: json['Gender'] != null ? json['Gender'].toString() : '',
      height: json['Height'] ?? '',
      ketLuan: json['ket_luan_suc_khoe_dinh_duong'] != null
          ? json['ket_luan_suc_khoe_dinh_duong'].toString()
          : '',
      month: json['Month'] != null ? json['Month'].toString() : '',
      monthsAgeCurrent: json['months_age_current'] != null
          ? int.parse(json['months_age_current'].toString())
          : 0,
      weight: json['Weight'] ?? '',
    );
  }
}
