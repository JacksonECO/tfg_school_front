import 'package:flutter/material.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:validatorless/validatorless.dart';

import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/home/controller/login_controller.dart';

class LoginWidget extends StatelessWidget {
  final LoginController controller;
  const LoginWidget({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      margin: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            ),
            padding: const EdgeInsets.fromLTRB(28, 32, 32, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.isSchool ? 'Portal da escola' : 'Portal Escolar',
                      style: context.style.robotoMedium.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.isSchool
                          ? 'Exclusivo para diretores e reitores'
                          : 'Faça login para continuar',
                      style: context.style.interRegular.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/img/login-img.png',
                  height: 100,
                ),
              ],
            ),
          ),
          Form(
            key: controller.form,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  InputRegister(
                    title: 'Email',
                    initialValue: controller.email,
                    onFieldSubmitted: (_) => controller.login(),
                    hintText: controller.isSchool ? 'escola@host.com' : 'usuario@host.com',
                    onChanged: (v) => controller.email = v,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.email('Email inválido')
                    ]),
                  ),
                  InputRegister(
                    title: 'Senha',
                    initialValue: controller.password,
                    hintText: '****',
                    obscureText: true,
                    onFieldSubmitted: (_) => controller.login(),
                    onChanged: (v) => controller.password = v,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.min(6, 'Mínimo 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        controller.forgotPassword(controller.isSchool ? true : false);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.lock, color: Colors.white60, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Esqueceu a senha?',
                            style: context.style.interLight.copyWith(
                              fontSize: 16,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    text: 'LOGIN',
                    borderRadius: 15,
                    onPressed: controller.login,
                    color: context.colors.primary,
                    height: 45,
                    withBorder: false,
                    width: double.infinity,
                  ),
                  if (controller.isSchool) ...[
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SchoolModule.registerRoute);
                      },
                      child: Text(
                        'Não tem uma conta? Cadastre sua Escola',
                        style: context.style.interLight.copyWith(
                          fontSize: 14,
                          color: Colors.white38,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: controller.switchTypeAccount,
                    child: Text(
                      controller.isSchool ? 'Entrar como Usuário' : 'Entrar como Escola',
                      style: context.style.interLight.copyWith(
                        fontSize: 14,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
