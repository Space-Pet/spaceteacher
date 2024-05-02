
/// Checks if string is email.
bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

/// Password should have,
/// at least a upper case letter
/// at least a lower case letter
/// at least a digit
/// at least a special character [@#$%^&+=]
/// length of at least 4
/// no white space allowed
bool isValidPassword(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;
  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }
  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$';
    final regExp = RegExp(pattern);
    isInputStringValid = regExp.hasMatch(inputString);
  }
  return isInputStringValid;
}

String getFileName(String filePath, {int maxLength = 24}) {
  if (filePath.isEmpty) {
    return 'Không có báo bài';
  }

  List<String> parts = filePath.split('-');
  List<String> remainingParts = parts.skip(4).toList();

  String name = remainingParts.join('-');

  if (name.length > maxLength) {
    name =
        "${name.substring(0, maxLength)}..-${name.substring(name.length - 5)}";
  }

  return name;
}
