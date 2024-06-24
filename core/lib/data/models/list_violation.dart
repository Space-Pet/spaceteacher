class ListViolation {
  final String viPhamId;
  final String viPhamName;
  ListViolation({required this.viPhamId, required this.viPhamName});
  factory ListViolation.fromJson(Map<String, dynamic> json) {
    return ListViolation(
      viPhamId: json['vi_pham_id'],
      viPhamName: json['vi_pham_name'],
    );
  }
  static List<ListViolation> fakeData() {
    return List.generate(10, (index) {
      return ListViolation(
        viPhamId: 'no data',
        viPhamName: 'no data',
      );
    });
  }
}
