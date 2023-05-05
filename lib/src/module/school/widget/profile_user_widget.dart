import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/cep_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/cpf_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/date_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/phone_input_formatter.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/module/school/model/class_model.dart';
import 'package:validatorless/validatorless.dart';

class ProfileUserWidget extends StatelessWidget {
  final ProfileUserController controller;
  const ProfileUserWidget({super.key, required this.controller});

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
                      controller.newUser ? 'Cadastre seu aluno' : 'Perfil',
                      style: context.style.robotoMedium.copyWith(
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.newUser
                          ? 'Preencha com os dados do aluno'
                          : 'Edite os dados abaixo',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: InputRegister(
                          title: 'Nome',
                          hintText: 'nome do aluno',
                          initialValue: controller.user.name,
                          onChanged: (v) => controller.user.name = v,
                          validator: Validatorless.required('Campo obrigatório'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: InputRegister(
                          title: 'Data de Nascimento',
                          hintText: '01/01/2000',
                          initialValue: controller.user.birthString,
                          onChanged: (v) => controller.user.birthString = v,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            DateInputFormatter.validator,
                          ]),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DateInputFormatter(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InputRegister(
                          title: 'Email',
                          hintText: 'escola@host.com',
                          initialValue: controller.user.email,
                          onChanged: (v) => controller.user.email = v,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.email('Email inválido'),
                          ]),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10, bottom: 4),
                                child: Text(
                                  'Turma',
                                  style: context.style.robotoRegular.copyWith(fontSize: 14),
                                ),
                              ),
                              Observer(builder: (_) {
                                return DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Selecione a turma',
                                    fillColor: context.colors.gray,
                                    filled: true,
                                  ),
                                  items: controller.classes.map((ClassModel value) {
                                    return DropdownMenuItem<ClassModel>(
                                      value: value,
                                      child: Text(value.name!),
                                    );
                                  }).toList(),
                                  onChanged: (v) => controller.user.classId = v?.id,
                                  validator: Validatorless.required('Campo obrigatório'),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: InputRegister(
                          title: 'Telefone',
                          hintText: '(00) 0000-0000',
                          initialValue: controller.user.phone,
                          onChanged: (v) => controller.user.phone = v,
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
                      const SizedBox(width: 16),
                      Flexible(
                        child: InputRegister(
                          title: 'CPF',
                          hintText: '000.000.000-00',
                          initialValue: controller.user.cpf,
                          onChanged: (v) => controller.user.cpf = v,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(14, 'CPF inválido'),
                            Constants.prod ? Validatorless.cpf('CPF inválido') : (_) => null,
                          ]),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: InputRegister(
                          title: 'RG',
                          hintText: 'documento',
                          initialValue: controller.user.rg,
                          onChanged: (v) => controller.user.rg = v,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(5, 'RG inválido'),
                            Validatorless.max(13, 'RG inválido'),
                          ]),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: InputRegister(
                          title: 'CEP',
                          hintText: '00000-000',
                          initialValue: controller.user.cep,
                          onChanged: (v) => controller.user.cep = v,
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
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 2,
                        child: InputRegister(
                          title: 'Endereço',
                          hintText: 'Rua A, 123',
                          initialValue: controller.user.address,
                          onChanged: (v) => controller.user.address = v,
                          validator: Validatorless.required('Campo obrigatório'),
                        ),
                      ),
                    ],
                  ),
                  if (controller.newUser)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: InputRegister(
                            title: 'Senha',
                            hintText: '********',
                            obscureText: true,
                            onChanged: (v) => controller.user.password = v,
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Mínimo 6 caracteres'),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
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
                        if (controller.image?.image != null)
                          Click(
                            onTap: controller.getImage,
                            child: Image.memory(
                              controller.image!.image!,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (controller.user.profilePicture != null &&
                            controller.user.profilePicture != '')
                          Click(
                            onTap: controller.getImage,
                            child: Image.network(
                              controller.user.profilePicture!,
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
                  const SizedBox(height: 16),
                  Button(
                    text: controller.newUser ? 'CRIAR CONTAS' : 'SALVAR',
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
