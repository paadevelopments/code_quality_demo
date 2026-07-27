/// Extensions for DateTime formatting.
extension DateExtensions on DateTime {
  /// Formats date to YYYY-MM-DD.
  String toAppDateString() {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}
