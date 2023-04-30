extension DoubleExtension on double {
  String get coin {
    return 'R\$ ${toStringAsFixed(2).replaceAll('.', ',')}';
  }

  double roundFix([int fix = 2]) {
    return double.parse(toStringAsFixed(fix));
  }
}
