import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/cep_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/cnpj_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/phone_input_formatter.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileWidget extends StatelessWidget {
  final ProfileController controller;
  const ProfileWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      controller.newSchool ? 'Cadastro' : 'Perfil',
                      style: context.style.robotoMedium.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.newSchool ? 'Preencha seus dados abaixo' : 'Edite os dados abaixo',
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
                  Observer(builder: (_) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logotipo:',
                          style: context.style.robotoRegular.copyWith(fontSize: 14),
                        ),
                        const SizedBox(width: 16),
                        if (controller.image?.image == null)
                          IconButton(
                            onPressed: controller.getImage,
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 18,
                            ),
                          )
                        else
                          Click(
                            onTap: controller.getImage,
                            child: Image.memory(
                              controller.image!.image!,
                              height: 150,
                              // width: 50,
                              fit: BoxFit.cover,
                            ),
                          )

                        // ListTile(
                        //   title: const Text('Logo'),
                        //   trailing:
                        //   // leading: const Icon(Icons.photo_library),
                        //   onTap: () async {

                        //   },
                        // ),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                  Button(
                    text: controller.newSchool ? 'CRIAR CONTAS' : 'SALVAR',
                    borderRadius: 15,
                    onPressed: controller.register,
                    color: context.colors.primary,
                    height: 45,
                    withBorder: false,
                    width: double.infinity,
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
