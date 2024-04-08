import 'package:json_annotation/json_annotation.dart';
part 'dish_menu_model.g.dart';

@JsonSerializable()
class Dish {
  final String? image;
  final String? dish;
  const Dish({this.dish, this.image});

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);

  Dish copyWith({
    String? image,
    String? dish,
  }) {
    return Dish(
      image: image ?? this.image,
      dish: dish ?? this.dish,
    );
  }

  @override
  String toString() {
    return 'Dish{image: $image, dish: $dish}';
  }
}
