/// Extensions for String validation.
extension ValidationExtensions on String? {
  /// Checks if string is a valid email.
  String? validateEmail() {
    if (this == null || this!.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(this!)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Checks if string is a valid password.
  String? validatePassword() {
    if (this == null || this!.isEmpty) {
      return 'Password is required';
    }
    if (this!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
