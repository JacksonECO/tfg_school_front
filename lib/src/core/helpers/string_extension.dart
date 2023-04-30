extension StringExtension on String {
  String get capitalCase {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
