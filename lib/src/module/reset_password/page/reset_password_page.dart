import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/reset_password/controller/reset_password_controller.dart';
import 'package:validatorless/validatorless.dart';

class ResetPasswordPage extends StatefulWidget {
  final String resetToken;

  const ResetPasswordPage({super.key, required this.resetToken});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controller = Modular.get<ResetPasswordController>();

  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction((_) => controller.status, (status) async {
      switch (status) {
        case ResetPasswordStateStatus.initial:
          break;
        case ResetPasswordStateStatus.loading:
          EasyLoading.show();
          break;
        case ResetPasswordStateStatus.loaded:
          EasyLoading.dismiss();
          await ModalAlert.show('Sucesso', controller.message!);
          Modular.to.navigate('/');
          break;
        case ResetPasswordStateStatus.error:
          EasyLoading.dismiss();
          ModalAlert.show('Ocorreu um erro', controller.message!);
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
                          'Preencha os dados abaixo',
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
                            title: 'Senha de Acesso',
                            hintText: 'Senha',
                            onFieldSubmitted: (_) => controller.resetPassword(widget.resetToken),
                            obscureText: true,
                            onChanged: (value) => controller.newPassword = value,
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Mínimo 6 caracteres'),
                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputRegister(
                            title: 'Confirme sua Senha',
                            hintText: 'Senha',
                            onFieldSubmitted: (_) => controller.resetPassword(widget.resetToken),
                            obscureText: true,
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Mínimo 6 caracteres'),
                              controller.verifyPassword,
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                            text: 'Redefinir Senha',
                            onPressed: () {
                              controller.resetPassword(widget.resetToken);
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
