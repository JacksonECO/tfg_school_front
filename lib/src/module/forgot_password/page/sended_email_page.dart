import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class ConfirmResetEmail extends StatelessWidget {
  const ConfirmResetEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (_, constraints) {
            return Container(
              width: 500,
              margin: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: context.colors.backgroundTitle,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recuperação de Senha',
                          style: context.style.poppinsRegular.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          'Enviamos um e-mail com instruções para redefinir sua senha',
                          style: context.style.poppinsRegular.copyWith(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(50.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Image.asset(
                              'assets/img/email-send.png',
                              height: 200,
                            ),
                          ),
                          Text(
                            'Verifique seu endereço de e-mail e siga o passo a passo',
                            style: context.style.poppinsRegular,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
