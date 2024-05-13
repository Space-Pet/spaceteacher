import 'package:core/presentation/screens/domain/domain_saver.dart';

class SingletonDomainSaver extends DomainSaver{
  static final SingletonDomainSaver _singleton = SingletonDomainSaver._internal();

  factory SingletonDomainSaver() {
    return _singleton;
  }

  SingletonDomainSaver._internal();
}