import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';

class HeaderWidget extends AppBar {
  HeaderWidget({super.key})
      : super(
          elevation: 0,
          toolbarHeight: 90,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/unifei-logo.png',
                width: 50,
              ),
              const SizedBox(width: 10),
              const Text(
                'UNIFEI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _button('Início'),
              _button('Cronograma'),
              _button('Cursos'),
              _button('FAQ'),
            ],
          ),
          actions: [
            IconButton(
              highlightColor: Colors.transparent,
              icon: const Icon(
                Icons.account_circle,
                size: 48,
              ),
              onPressed: () {},
            )
          ],
        );

  static Widget _button(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return CustomColors.i.primary;
            }
            return Colors.white;
          }),
        ),
        onPressed: () {},
        child: Text(title),
      ),
    );
  }
}
