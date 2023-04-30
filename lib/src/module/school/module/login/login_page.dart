import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/cep_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/cnpj_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/phone_input_formatter.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/module/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class SchoolLoginPage extends StatelessWidget {
  final SchoolLoginController controller;
  const SchoolLoginPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPage(body: [
      Container(
          width: 850,
          margin: const EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          'Cadastre sua Escola',
                          style: context.style.robotoMedium.copyWith(
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Preencha os dados abaixo',
                          style: context.style.interRegular.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/img/register-user.png',
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
                        title: 'Escola',
                        hintText: 'Nome completo da escola',
                        onChanged: (v) => controller.school.name = v,
                        validator: Validatorless.required('Campo obrigatório'),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InputRegister(
                              title: 'Email',
                              hintText: 'escola@host.com',
                              onChanged: (v) => controller.school.email = v,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.email('Email inválido'),
                              ]),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InputRegister(
                              title: 'Telefone',
                              hintText: '(00) 0000-0000',
                              onChanged: (v) => controller.school.phone = v,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.between(14, 15, 'Telefone inválido'),
                              ]),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                PhoneInputFormatter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InputRegister(
                              title: 'CNPJ',
                              hintText: '00.000.000/0000-00',
                              onChanged: (v) => controller.school.cnpj = v,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(18, 'CNPJ inválido'),
                                // TODO: Ativar validação de CNPJ
                                // Validatorless.cnpj('CNPJ inválido'),
                              ]),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CnpjInputFormatter()
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InputRegister(
                              title: 'CEP',
                              hintText: '00000-000',
                              onChanged: (v) => controller.school.cep = v,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(9, 'CEP inválido'),
                              ]),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InputRegister(
                              title: 'Senha',
                              hintText: '********',
                              obscureText: true,
                              onChanged: (v) => controller.school.password = v,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(6, 'Mínimo 6 caracteres'),
                              ]),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InputRegister(
                              title: 'Confirme sua Senha',
                              hintText: '********',
                              obscureText: true,
                              validator: Validatorless.multiple([
                                Validatorless.required('Campo obrigatório'),
                                Validatorless.min(6, 'Mínimo 6 caracteres'),
                                controller.verifyPassword,
                              ]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Button(
                        text: 'SALVAR',
                        borderRadius: 15,
                        onPressed: controller.register,
                        color: context.colors.primary,
                        height: 45,
                        withBorder: false,
                        width: double.infinity,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ))
    ]);
  }
}
