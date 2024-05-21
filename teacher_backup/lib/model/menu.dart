import 'package:json_annotation/json_annotation.dart';
import 'package:teacher/model/dish_menu_model.dart';
import 'package:teacher/model/item_menu_model.dart';
import 'package:teacher/resources/assets.gen.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  final Item? item;

  const Menu({
    this.item,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);

  Menu copyWith({
    Item? item,
  }) {
    return Menu(
      item: item ?? this.item,
    );
  }

  @override
  String toString() {
    return 'Menu{item: $item}';
  }
}

final List<Menu> menu = [
  Menu(
    item: Item(decscription: 'Bữa sáng', dish: [
      Dish(dish: 'Vịt om sấu', image: Assets.images.menu1.path),
      Dish(
          dish: 'Cá rô phi fillet xào nấm tuyết',
          image: Assets.images.menu2.path),
      Dish(dish: 'Canh chua gà', image: Assets.images.menu3.path),
      Dish(dish: 'Cơm trắng', image: Assets.images.menu4.path),
      Dish(dish: 'Thanh long ruột đỏ', image: Assets.images.menu5.path),
    ]),
  ),
  const Menu(
    item: Item(decscription: 'Bữa trưa', dish: [
      Dish(dish: 'Vịt om sấu', image: 'assets/images/menu1.png'),
      Dish(
          dish: 'Cá rô phi fillet xào nấm tuyết',
          image: 'assets/images/menu2.png'),
      Dish(dish: 'Canh chua gà', image: 'assets/images/menu3.png'),
      Dish(dish: 'Cơm trắng', image: 'assets/images/menu4.png'),
      Dish(dish: 'Thanh long ruột đỏ', image: 'assets/images/menu5.png'),
    ]),
  ),
  const Menu(
    item: Item(decscription: 'Bữa xế', dish: [
      Dish(dish: 'Vịt om sấu', image: 'assets/images/menu1.png'),
      Dish(
          dish: 'Cá rô phi fillet xào nấm tuyết',
          image: 'assets/images/menu2.png'),
      Dish(dish: 'Canh chua gà', image: 'assets/images/menu3.png'),
      Dish(dish: 'Cơm trắng', image: 'assets/images/menu4.png'),
      Dish(dish: 'Thanh long ruột đỏ', image: 'assets/images/menu5.png'),
    ]),
  ),
  const Menu(
    item: Item(decscription: 'Bữa tối', dish: [
      Dish(dish: 'Vịt om sấu', image: 'assets/images/menu1.png'),
      Dish(
          dish: 'Cá rô phi fillet xào nấm tuyết',
          image: 'assets/images/menu2.png'),
      Dish(dish: 'Canh chua gà', image: 'assets/images/menu3.png'),
      Dish(dish: 'Cơm trắng', image: 'assets/images/menu4.png'),
      Dish(dish: 'Thanh long ruột đỏ', image: 'assets/images/menu5.png'),
    ]),
  ),
];
