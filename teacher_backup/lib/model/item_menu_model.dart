import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/dish_menu_model.dart';

part 'item_menu_model.g.dart';

@JsonSerializable()
class Item {
  final String? decscription;
  final List<Dish>? dish;

  const Item({
    this.dish,
    this.decscription,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    String? decscription,
    List<Dish>? dish,
  }) {
    return Item(
      decscription: decscription ?? this.decscription,
      dish: dish ?? this.dish,
    );
  }

  @override
  String toString() {
    return 'Item{decscription: $decscription, dish: $dish}';
  }
}
