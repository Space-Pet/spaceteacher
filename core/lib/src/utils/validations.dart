class Validations {
  static bool phoneNumber(String input) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    return phoneRegex.hasMatch(input);
  }
}
