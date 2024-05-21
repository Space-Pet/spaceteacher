class Menu {
  final Item item;

  const Menu({
    required this.item,
  });
}

class Item {
  final String decscription;
  final List<Dish> dish;

  const Item({
    required this.dish,
    required this.decscription,
  });
}

class Dish {
  final String image;
  final String dish;
  const Dish({required this.dish, required this.image});
}

final List<Menu> menu = [
  const Menu(
    item: Item(decscription: 'Bữa sáng', dish: [
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
