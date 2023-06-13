import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/cep_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/cnpj_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/phone_input_formatter.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.colors.backgroundTitle,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.newSchool ? 'Cadastro' : 'Perfil',
                      style: context.style.poppinsMedium.copyWith(
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
              padding: const EdgeInsets.fromLTRB(30, 16, 30, 30),
              child: Column(
                children: [
                  Observer(builder: (_) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logotipo:',
                          style: context.style.poppinsRegular.copyWith(fontSize: 14),
                        ),
                        const SizedBox(width: 16),
                        if (controller.image?.image != null)
                          Click(
                            onTap: controller.getImage,
                            child: Image.memory(
                              controller.image!.image!,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (controller.school.logo != null && controller.school.logo != '')
                          Click(
                            onTap: controller.getImage,
                            child: Image.network(
                              controller.school.logo!,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        else
                          IconButton(
                            onPressed: controller.getImage,
                            icon: const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 18,
                            ),
                          )
                      ],
                    );
                  }),
                  InputRegister(
                    title: 'Escola',
                    hintText: 'Nome completo da escola',
                    initialValue: controller.school.name,
                    onChanged: (v) => controller.school.name = v,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InputRegister(
                          enabled: controller.newSchool,
                          title: 'Email',
                          hintText: 'escola@host.com',
                          initialValue: controller.school.email,
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
                          initialValue: controller.school.phone,
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
                          initialValue: controller.school.cnpj,
                          onChanged: (v) => controller.school.cnpj = v,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(18, 'CNPJ inválido'),
                            Constants.prod ? Validatorless.cnpj('CNPJ inválido') : (_) => null,
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
                          initialValue: controller.school.cep,
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
                  if (controller.newSchool)
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
                    text: controller.newSchool ? 'Criar Conta' : 'Salvar',
                    borderRadius: 10,
                    onPressed: controller.save,
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
