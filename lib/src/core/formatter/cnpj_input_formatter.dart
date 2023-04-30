// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/services.dart';

class CnpjInputFormatter extends TextInputFormatter {
  // ##.###.###/####-##

  static String format(String text) {
    if (text.length == 14) {
      return CnpjInputFormatter()
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

    if (newValueLength > 2) {
      newText.write(newValue.text.substring(0, substrIndex = 2) + '.');
      if (newValue.selection.end >= 2) selectionIndex++;
    }
    if (newValueLength > 5) {
      newText.write(newValue.text.substring(2, substrIndex = 5) + '.');
      if (newValue.selection.end >= 5) selectionIndex++;
    }
    if (newValueLength > 8) {
      newText.write(newValue.text.substring(5, substrIndex = 8) + '/');
      if (newValue.selection.end >= 8) selectionIndex++;
    }
    if (newValueLength > 12) {
      newText.write(newValue.text.substring(8, substrIndex = 12) + '-');
      if (newValue.selection.end >= 12) selectionIndex++;
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
