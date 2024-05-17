part of 'extention.dart';

extension BaseContext on BuildContext {
  TextStyle get listHeading => Theme.of(this)
      .textTheme
      .titleMedium!
      .copyWith(fontWeight: FontWeight.w400);

  Future<dynamic> push(String routeName, {Object? arguments}) async =>
      await Navigator.of(this).pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacement(String routeName,
          {Object? arguments, Object? result}) async =>
      await Navigator.of(this).pushReplacementNamed(routeName,
          arguments: arguments, result: result);

  Future<dynamic> pushAndRemoveUntil(String routeName, RoutePredicate predicate,
          {Object? arguments, Object? result}) async =>
      await Navigator.of(this)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  Future<dynamic> popAndPush(String routeName,
          {Object? arguments, Object? result}) async =>
      await Navigator.of(this)
          .popAndPushNamed(routeName, arguments: arguments, result: result);

  void pop({Object? result}) => Navigator.of(this).pop(result);

  void popUntil(RoutePredicate predicate) =>
      Navigator.of(this).popUntil(predicate);
}
