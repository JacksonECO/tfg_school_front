import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/module/school/widget/subject_widget.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/class_controller.dart';
import 'package:validatorless/validatorless.dart';

class ClassWidget extends StatelessWidget {
  final ClassController controller;
  const ClassWidget({super.key, required this.controller});

  static Future showModal({
    required ClassController classController,
  }) {
    return showDialog(
      context: Constants.context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ClassWidget(
              controller: classController,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: controller.future,
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
                            controller.newClass ? 'Cadastrar nova Turma' : 'Editar Turma',
                            style: context.style.poppinsRegular.copyWith(
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Preencha com os dados abaixo',
                            style: context.style.interRegular.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/img/register-user.png',
                        height: 116,
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
                          title: 'Nome',
                          hintText: 'Nome',
                          initialValue: controller.classModel.name,
                          onChanged: (v) => controller.classModel.name = v,
                          validator: Validatorless.required('Campo obrigatório'),
                        ),
                        const SizedBox(height: 16),
                        Observer(builder: (_) {
                          return ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: controller.classModel.subjects.length,
                            separatorBuilder: (context, index) => const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              return Observer(builder: (_) {
                                return SubjectWidget(
                                  key: Key(index.toString()),
                                  index: index,
                                  subject: controller.classModel.subjects[index],
                                  controller: controller,
                                );
                              });
                            },
                          );
                        }),
                        const SizedBox(height: 16),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: controller.addSubject,
                        ),
                        const SizedBox(height: 16),
                        Button(
                          text: controller.newClass ? 'Criar Turma' : 'Salvar Turma',
                          borderRadius: 15,
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
        });
  }
}
