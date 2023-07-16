import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';
import 'package:validatorless/validatorless.dart';

class ModuleCourseWidget extends StatefulWidget {
  final ModuleCourseModel module;
  const ModuleCourseWidget({
    required this.module,
    super.key,
  });

  Future<ModuleCourseModel?> openModal(BuildContext context) async {
    return showDialog<ModuleCourseModel>(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  State<ModuleCourseWidget> createState() => _ResourceBasicWidgetState();
}

class _ResourceBasicWidgetState extends State<ModuleCourseWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleEC = TextEditingController();
  final TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    titleEC.text = widget.module.title;
    descriptionEC.text = widget.module.description;
    super.initState();
  }

  @override
  void dispose() {
    titleEC.dispose();
    descriptionEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      padding: const EdgeInsets.all(80),
      child: AlertDialog(
        backgroundColor: context.colors.secondary,
        titlePadding: const EdgeInsets.only(bottom: 38, left: 50, right: 50, top: 38),
        buttonPadding: const EdgeInsets.only(left: 8, right: 8),
        title: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SelectableText(
            "Novo Módulo",
            style: context.style.poppinsRegular.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Form(
            key: _formKey,
            child: SizedBox(
              width: 700,
              child: Column(
                children: [
                  InputRegister(
                    title: 'Nome',
                    hintText: 'Informe o nome do módulo',
                    controller: titleEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                      Validatorless.max(255, 'Nº máximo de caracteres ultrapassado')
                    ]),
                  ),
                  InputRegister(
                    controller: descriptionEC,
                    title: 'Descrição',
                    hintText: 'Resumo prévio do módulo',
                    validator: Validatorless.multiple([
                      Validatorless.required('Campo obrigatório'),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          color: const Color(0xffFF3B3B),
                          text: 'Cancelar',
                          height: 50,
                          withBorder: false,
                          onPressed: () => Navigator.of(context).pop(null),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Button(
                          color: const Color(0xff6776ED),
                          text: 'Confirmar',
                          height: 50,
                          withBorder: false,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).pop(widget.module.copyWith(
                                title: titleEC.text,
                                description: descriptionEC.text,
                              ));

                              titleEC.clear();
                              descriptionEC.clear();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
