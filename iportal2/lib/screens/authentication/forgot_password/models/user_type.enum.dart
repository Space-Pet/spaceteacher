enum UserType { parent, pupil }

extension UserTypeX on UserType {
  String get label {
    switch (this) {
      case UserType.parent:
        return 'Cha mẹ học sinh';
      case UserType.pupil:
        return 'Học sinh';
      default:
        return '';
    }
  }
}
