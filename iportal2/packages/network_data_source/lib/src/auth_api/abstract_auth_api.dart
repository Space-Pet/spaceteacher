
enum UserType { professional, talent }

extension UserTypeX on UserType {
  bool get isProfessional => this == UserType.professional;
  bool get isTalent => this == UserType.talent;

  String get stringType {
    return isProfessional ? "p" : "t";
  }
}

abstract class AbstractAuthApi {

}
