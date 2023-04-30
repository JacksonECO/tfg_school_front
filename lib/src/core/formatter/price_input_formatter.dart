import 'package:flutter/services.dart';

class PriceInputFormatter extends TextInputFormatter {
  // ###.###.###.###,##

  static String format(String text) {
    if (text.isNotEmpty) {
      return PriceInputFormatter()
          .formatEditUpdate(TextEditingValue.empty,
              TextEditingValue(text: text.replaceAll('.', '').replaceAll(',', '')))
          .text;
    }
    return '0,00';
  }

  static String formatNumber(num number) {
    return format(number.toStringAsFixed(2));
  }

  // Melhorias:

  // - Remover o 0 a esquerda
  // - Fazer um padLeft para completar com 0 a esquerda, min de 3 caracteres
  // - Aplicar a formatação

  // - Usar uma List.generate baseado no tamanho do texto para add os pontos

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final index = newValue.selection.end;
    int indexCount = 0;

    List<String> value = newValue.text.split('').reversed.toList();

    while (value.length > 2 && value.last == '0') {
      value.removeLast();
      indexCount--;
    }

    if (value.length > 2) {
      value.insert(2, ',');
      if (index >= value.length - 2) indexCount++;
    }
    if (value.length > 6) {
      value.insert(6, '.');
      if (index >= value.length - 6) indexCount++;
    }
    if (value.length > 10) {
      value.insert(10, '.');
      if (index >= value.length - 10) indexCount++;
    }
    if (value.length > 14) {
      value.insert(14, '.');
      if (index >= value.length - 14) indexCount++;
    }

    var valueString = value.reversed.toList().join();
    if (!valueString.contains(',') &&
        valueString.isNotEmpty &&
        valueString.contains(RegExp(r'[1-9]'))) {
      if (valueString.length == 1) {
        valueString = '0,0$valueString';
        indexCount += 3;
      } else if (valueString.length == 2) {
        valueString = '0,$valueString';
        indexCount += 2;
      }
    }

    if (valueString == '00') {
      valueString = '0';
      indexCount -= 1;
    }

    return TextEditingValue(
      text: valueString,
      selection: TextSelection.collapsed(offset: index + indexCount),
    );
  }
}
