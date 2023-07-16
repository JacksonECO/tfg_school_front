extension DateTimeExtension on DateTime {
  String get day2 => day.toString().padLeft(2, '0');
  String get month2 => month.toString().padLeft(2, '0');
  String get year2 => year.toString().padLeft(2, '0');

  String get date => '$day2/$month2/$year';

  int get random {
    return int.parse(microsecondsSinceEpoch.toString().substring(7));
  }
}
