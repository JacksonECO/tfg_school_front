import 'package:flutter/services.dart';

class CepInputFormatter extends TextInputFormatter {
  // #####-###

  static String format(String text) {
    if (text.length == 8) {
      return CepInputFormatter()
          .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
          .text;
    }
    return '';
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    if (newValue.text.length > 8) {
      return oldValue;
    }

    if (newTextLength > 5) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 5)}-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }

    // Dump the rest.
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
