import 'package:flutter/services.dart';

class HourInputFormatter extends TextInputFormatter {
  // ##:##

  static String format(String text) {
    if (text.length == 4 || text.length == 5) {
      return HourInputFormatter()
          .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
          .text;
    }
    return '';
  }

  static get validator => (input) {
        try {
          if (input == null || input.isEmpty) {
            return 'Campo obrigatório';
          }
          if (input.length != 5) {
            return 'Hora inválida';
          }

          final split = input.split(':');
          final hour = int.parse(split[0]);
          final minute = int.parse(split[1]);

          if (hour < 0 || hour > 23) {
            return 'Hora inválida';
          }

          if (minute < 0 || minute > 59) {
            return 'Hora inválida';
          }

          return null;
        } catch (e) {
          return 'Data inválida';
        }
      };

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    if (newValue.text.length > 4) {
      return oldValue;
    }

    if (newTextLength > 2) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)}:');
      if (newValue.selection.end > 2) selectionIndex++;
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
