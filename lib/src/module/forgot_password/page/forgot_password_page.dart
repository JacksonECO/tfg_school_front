import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/forgot_password/controller/forgot_password_controller.dart';
import 'package:tfg_front/src/module/forgot_password/forgot_password_module.dart';
import 'package:validatorless/validatorless.dart';

class ForgotPasswordPage extends StatefulWidget {
  final bool isSchool;
  const ForgotPasswordPage({super.key, required this.isSchool});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final controller = ForgotPasswordController();

  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction((_) => controller.status, (status) async {
      switch (status) {
        case ForgotPasswordStateStatus.initial:
          break;
        case ForgotPasswordStateStatus.loading:
          EasyLoading.show();
          break;
        case ForgotPasswordStateStatus.loaded:
          EasyLoading.dismiss();
          await ModalAlert.show('Sucesso', controller.message!);
          Modular.to.navigate(ForgotPasswordModule.emailSendedRoute);
          break;
        case ForgotPasswordStateStatus.error:
          EasyLoading.dismiss();
          ModalAlert.show('Ocorreu um Erro', controller.message!);
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    statusReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (_, constraints) {
            return Container(
              width: 550,
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
                    padding: const EdgeInsets.fromLTRB(50, 30, 50, 30),
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
                          'Preencha os dados abaixo e te enviaremos um e-mail de recuperação',
                          style: context.style.poppinsRegular.copyWith(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  Form(
                    key: controller.form,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
                      child: Column(
                        children: [
                          InputRegister(
                            title: 'Email',
                            hintText: 'Email',
                            onFieldSubmitted: (_) => controller.preResetPassword(widget.isSchool),
                            onChanged: (value) => controller.email = value,
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Button(
                            text: 'Enviar e-mail',
                            onPressed: () {
                              controller.preResetPassword(widget.isSchool);
                            },
                            color: context.colors.blue,
                            height: 45,
                            withBorder: false,
                            borderRadius: 5,
                            width: double.infinity,
                          )
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
