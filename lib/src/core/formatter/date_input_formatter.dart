import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  // ##/##/####

  static String format(String text) {
    if (text.length == 10 || text.length == 11) {
      return DateInputFormatter()
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
          if (input.length != 10) {
            return 'Data inválida';
          }

          final split = input.split('/');
          final day = int.parse(split[0]);
          final month = int.parse(split[1]);
          final year = int.parse(split[2]);

          final date = DateTime(year, month, day);

          if (date.day != day || date.month != month || date.year != year) {
            return 'Data inválida';
          }
          if (date.isAfter(DateTime.now())) {
            return 'Deve ser uma data no passado';
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

    if (newValue.text.length > 8) {
      return oldValue;
    }

    if (newTextLength > 2) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)}/');
      if (newValue.selection.end > 2) selectionIndex++;
    }
    if (newTextLength > 4) {
      newText.write('${newValue.text.substring(2, usedSubstringIndex = 4)}/');
      if (newValue.selection.end > 4) selectionIndex++;
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
