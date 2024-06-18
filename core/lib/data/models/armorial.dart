class Armorial {
  final int huyHieuId;
  final String huyHieuName;
  final String huyHieuImg;

  Armorial({
    required this.huyHieuId,
    required this.huyHieuName,
    required this.huyHieuImg,
  });

  factory Armorial.fromJson(Map<String, dynamic> json) {
    return Armorial(
      huyHieuId: json['huy_hieu_id'],
      huyHieuName: json['huy_hieu_name'],
      huyHieuImg: json['huy_hieu_img'],
    );
  }

  static List<Armorial> fakeData() {
    return [
      Armorial(
          huyHieuId: 1,
          huyHieuName: "1. Chiến binh ưu tú",
          huyHieuImg: "https://iportal.nhg.vn/upload/logos/mn-uu-tu.png"),
      Armorial(
          huyHieuId: 2,
          huyHieuName: "2. Chiến binh vượt trội",
          huyHieuImg: "https://iportal.nhg.vn/upload/logos/mn-vuot-troi.png"),
      Armorial(
          huyHieuId: 3,
          huyHieuName: "3. Chiến binh chăm chỉ",
          huyHieuImg: "https://iportal.nhg.vn/upload/logos/mn-cham-chi.png"),
    ];
  }
}
