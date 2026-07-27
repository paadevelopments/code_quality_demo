/// Common extensions for the String class.
extension StringExtensions on String {
  /// Checks if the string is a valid email.
  bool get isValidEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  /// Capitalizes the string.
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
