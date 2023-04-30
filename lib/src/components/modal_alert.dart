import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';

class ModalAlert {
  static Future<T?> show<T>(String title, String message) {
    return showDialog<T>(
      context: Constants.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
