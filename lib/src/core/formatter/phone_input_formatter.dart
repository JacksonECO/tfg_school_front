import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  // (##) ####-#### or (##) #####-####

  static String format(String text) {
    if (text.length == 10 || text.length == 11) {
      return PhoneInputFormatter()
          .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
          .text;
    }
    return '';
  }

  static List<String> phoneSearch(String phone) {
    final temp = <String>[];
    final clear = phone.replaceAll(RegExp('[() -]'), '');

    // Completo
    temp.add(clear);
    // Sem 9
    if (clear.length == 9) temp.add(clear.substring(1));
    // Sem  DD
    if (clear.length >= 10) temp.add(clear.substring(2));
    // Sem DD e 9
    if (clear.length == 11) temp.add(clear.substring(3));
    // Removendo apenas o 9
    if (clear.length == 11) temp.add(clear.substring(0, 2) + clear.substring(3));

    return temp;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    final StringBuffer newText = StringBuffer();
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    if (newValue.text.length > 11) {
      return oldValue;
    }

    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 3) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 2)}) ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      if (newTextLength == 11) {
        newText.write('${newValue.text.substring(2, usedSubstringIndex = 7)}-');
        if (newValue.selection.end >= 7) selectionIndex++;
      } else {
        newText.write('${newValue.text.substring(2, usedSubstringIndex = 6)}-');
        if (newValue.selection.end >= 6) selectionIndex++;
      }
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
