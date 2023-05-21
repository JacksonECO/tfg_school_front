import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class ModalAlert {
  static Future<void> show(String title, String message) {
    return showDialog<void>(
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

  static Future<bool> showConfirmRemove(String title) async {
    return await showDialog<bool>(
          context: Constants.context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 200),
              padding: const EdgeInsets.all(80),
              child: AlertDialog(
                titlePadding: const EdgeInsets.only(bottom: 38, left: 100, right: 100, top: 38),
                buttonPadding: const EdgeInsets.only(left: 8, right: 8),
                title: Text(
                  title,
                  style: context.style.poppinsRegular.copyWith(fontSize: 28),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  Button(
                    color: const Color(0xffFF3B3B),
                    text: 'Cancelar',
                    height: 50,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  Button(
                    color: const Color(0xff6776ED),
                    text: 'Confirmar',
                    height: 50,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }
}
