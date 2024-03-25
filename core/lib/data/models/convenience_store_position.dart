class ConvenienceStorePosistion {
  final String id;
  final String name;
  final List<double> coordinates;

  ConvenienceStorePosistion({
    required this.id,
    required this.name,
    required this.coordinates,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'coordinates': coordinates,
    };
  }

  factory ConvenienceStorePosistion.fromMap(Map<String, dynamic> map) {
    return ConvenienceStorePosistion(
      id: map['id'] as String,
      name: map['name'] as String,
      coordinates: (map['position']['coordinates'] as List)
          .map((e) => e as double)
          .toList(),
    );
  }
}
