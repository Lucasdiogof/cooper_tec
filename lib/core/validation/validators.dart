abstract final class Validators {
  static const minPasswordLength = 6;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static bool isValidEmail(String value) =>
      _emailPattern.hasMatch(value.trim());

  static bool isValidPassword(String value) =>
      value.length >= minPasswordLength;
}
