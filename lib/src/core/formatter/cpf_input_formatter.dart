// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  // ###.###.###-##

  static String format(String text) {
    if (text.length == 14) {
      return CpfInputFormatter()
          .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
          .text;
    }
    return '';
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;
    var selectionIndex = newValue.selection.end;

    var substrIndex = 0;
    final newText = StringBuffer();

    if (newValueLength > 14) {
      return oldValue;
    }

    if (newValueLength > 3) {
      newText.write(newValue.text.substring(0, substrIndex = 3) + '.');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newValueLength > 6) {
      newText.write(newValue.text.substring(3, substrIndex = 6) + '.');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newValueLength > 9) {
      newText.write(newValue.text.substring(6, substrIndex = 9) + '-');
      if (newValue.selection.end >= 9) selectionIndex++;
    }
    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
