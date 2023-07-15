import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';

class HeaderWidget extends AppBar {
  HeaderWidget({super.key})
      : super(
          elevation: 0,
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          title: LayoutBuilder(builder: (context, _) {
            return Padding(
              padding: context.width < 550
                  ? const EdgeInsets.all(0)
                  : EdgeInsets.symmetric(horizontal: context.width * 0.07, vertical: max(40, context.width * 0.05)),
              child: Row(
                mainAxisAlignment: context.width < 550 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/black-board-logo.png',
                        height: 40,
                      ),
                      const SizedBox(width: 32),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Image.asset(
                          'assets/img/logo_name.png',
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  if (context.width > 550)
                    Row(
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.hovered)) {
                                return CustomColors.i.primary;
                              }
                              return Colors.white;
                            }),
                          ),
                          onPressed: () {
                            Modular.to.pushNamed(HomeModule.loginUserRoute);
                          },
                          child: Text(
                            'Entrar',
                            style: CustomTextStyle.i.interBold.copyWith(fontSize: 22),
                          ),
                        ),
                        const SizedBox(width: 30),
                        if (context.width > 775)
                          Button(
                            text: 'Cadastre sua Escola',
                            onPressed: () {
                              Modular.to.pushNamed(SchoolModule.registerRoute);
                            },
                            color: CustomColors.i.primary,
                            height: 34,
                            borderSide: const BorderSide(color: Colors.white, width: 1),
                            withBorder: true,
                            withRadius: true,
                            borderRadius: 20,
                          )
                      ],
                    ),
                ],
              ),
            );
          }),
        );

  // static Widget _button(String title, Function()? onPressed) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20),
  //     child: TextButton(
  //       style: ButtonStyle(
  //         overlayColor: MaterialStateProperty.all(Colors.transparent),
  //         foregroundColor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.hovered)) {
  //             return CustomColors.i.primary;
  //           }
  //           return Colors.white;
  //         }),
  //       ),
  //       onPressed: onPressed,
  //       child: Text(title),
  //     ),
  //   );
  // }
}
