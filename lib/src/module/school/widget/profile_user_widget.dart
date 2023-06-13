import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/cpf_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/date_input_formatter.dart';
import 'package:tfg_front/src/core/formatter/phone_input_formatter.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/model/class_model.dart';
import 'package:validatorless/validatorless.dart';

class ProfileUserWidget extends StatelessWidget {
  final ProfileUserController controller;
  const ProfileUserWidget({super.key, required this.controller});

  static Future showModal({
    required ProfileUserController profileUserController,
  }) {
    return showDialog(
      context: Constants.context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ProfileUserWidget(
              controller: profileUserController,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: controller.getUser,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar dados',
                style: context.style.interRegular.copyWith(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                            controller.newUser
                                ? 'Cadastrar novo ${controller.typeUser}'
                                : 'Editar Perfil do ${controller.typeUser}',
                            style: context.style.poppinsMedium.copyWith(
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Preencha com os dados abaixo',
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
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.secondary,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: Form(
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
                                  'Perfil:',
                                  style: context.style.poppinsMedium.copyWith(fontSize: 14),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: InputRegister(
                                  title: 'Nome',
                                  hintText: 'Nome completo',
                                  initialValue: controller.user.name,
                                  onChanged: (v) => controller.user.name = v,
                                  validator: Validatorless.required('Campo obrigatório'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: InputRegister(
                                  title: 'Email',
                                  hintText: 'Email',
                                  initialValue: controller.user.email,
                                  onChanged: (v) => controller.user.email = v,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Campo obrigatório'),
                                    Validatorless.email('Email inválido'),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: InputRegister(
                                  title: 'Data de Nascimento',
                                  hintText: 'Data de Nascimento',
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
                              const SizedBox(width: 16),
                              controller.isStudent
                                  ? Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10, bottom: 4),
                                              child: Text(
                                                'Turma',
                                                style: context.style.poppinsRegular
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ),
                                            Observer(builder: (_) {
                                              // FIX: Atualizar para o InputOptionsRegister
                                              return DropdownButtonFormField<ClassModel>(
                                                value: controller.userClass,
                                                decoration: InputDecoration(
                                                  hintText: 'Selecione a turma',
                                                  fillColor: context.colors.gray,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(4),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                                items: controller.classes.map((ClassModel value) {
                                                  return DropdownMenuItem<ClassModel>(
                                                    value: value,
                                                    child: Text(value.name!),
                                                  );
                                                }).toList(),
                                                onChanged: (v) => controller.user.classId = v?.id,
                                                validator:
                                                    Validatorless.required('Campo obrigatório'),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Flexible(
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
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.isStudent)
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
                              if (controller.isStudent) const SizedBox(width: 16),
                              Flexible(
                                child: InputRegister(
                                  title: 'CPF',
                                  hintText: '000.000.000-00',
                                  initialValue: controller.user.cpf,
                                  onChanged: (v) => controller.user.cpf = v,
                                  validator: Validatorless.multiple([
                                    Validatorless.required('Campo obrigatório'),
                                    Validatorless.min(14, 'CPF inválido'),
                                    Constants.prod
                                        ? Validatorless.cpf('CPF inválido')
                                        : (_) => null,
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
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Flexible(
                          //       child: InputRegister(
                          //         title: 'CEP',
                          //         hintText: '00000-000',
                          //         initialValue: controller.user.cep,
                          //         onChanged: (v) => controller.user.cep = v,
                          //         validator: Validatorless.multiple([
                          //           Validatorless.required('Campo obrigatório'),
                          //           Validatorless.min(9, 'CEP inválido'),
                          //         ]),
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.digitsOnly,
                          //           CepInputFormatter(),
                          //         ],
                          //       ),
                          //     ),
                          //     const SizedBox(width: 16),
                          //     Flexible(
                          //       flex: 2,
                          //       child:
                          InputRegister(
                            title: 'Endereço',
                            hintText: 'Rua A, 123',
                            initialValue: controller.user.address,
                            onChanged: (v) => controller.user.address = v,
                            validator: Validatorless.required('Campo obrigatório'),
                          ),
                          //     ),
                          //   ],
                          // ),
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

                          Button(
                            text: controller.newUser ? 'Criar Conta' : 'Salvar',
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
                ),
              ],
            ),
          );
        });
  }
}
