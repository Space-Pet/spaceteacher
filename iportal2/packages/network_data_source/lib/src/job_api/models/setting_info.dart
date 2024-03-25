class SettingInfo {
  final bool data;
  SettingInfo({
    required this.data,
});
  factory SettingInfo.fromMap(Map<String, dynamic> map){
    return SettingInfo(
      data: map['data'],
    );
  }
}