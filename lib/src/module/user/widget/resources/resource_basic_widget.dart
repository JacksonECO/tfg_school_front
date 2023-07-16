import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/user/model/basic_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_enum.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:validatorless/validatorless.dart';

class ResourceBasicWidget extends StatefulWidget {
  final BasicItemModuleCourseModel module;
  final bool onlyView;
  const ResourceBasicWidget({
    required this.module,
    this.onlyView = false,
    super.key,
  });

  Future<BasicItemModuleCourseModel?> openModal(BuildContext context) async {
    return showDialog<BasicItemModuleCourseModel>(
      context: context,
      builder: (context) => this,
    );
  }

  static Widget tile({
    required ItemModuleCourseModel item,
    required void Function() onTap,
    required void Function() onEdit,
    required void Function() onDelete,
  }) {
    final isProf = Modular.get<AuthModel>().role == AuthRoleEnum.teacher;
    return Click(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.all(6),
            color: item.type.color,
            child: Image.asset(
              item.type.pathIcon,
              height: 26,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.title,
            style: CustomTextStyle.i.text,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          if (isProf)
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit),
            ),
          if (isProf)
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete),
            ),
        ],
      ),
    );
  }

  @override
  State<ResourceBasicWidget> createState() => _ResourceBasicWidgetState();
}

class _ResourceBasicWidgetState extends State<ResourceBasicWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleEC = TextEditingController();
  final TextEditingController contentEC = TextEditingController();

  @override
  void initState() {
    titleEC.text = widget.module.title;
    contentEC.text = widget.module.content;
    super.initState();
  }

  @override
  void dispose() {
    titleEC.dispose();
    contentEC.dispose();
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
            widget.onlyView ? widget.module.title : widget.module.type.title,
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
                children: widget.onlyView
                    ? [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.module.content,
                            style: context.style.poppinsRegular.copyWith(fontSize: 16),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]
                    : [
                        InputRegister(
                          title: 'Título',
                          hintText: 'Nome do recurso',
                          controller: titleEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.max(255, 'Nº máximo de caracteres ultrapassado')
                          ]),
                        ),
                        InputRegister(
                          controller: contentEC,
                          title: widget.module.type == ItemModuleCourseEnum.link ? 'URL' : 'Conteúdo',
                          hintText: widget.module.type == ItemModuleCourseEnum.link ? 'https://google.com.br' : '',
                          validator: Validatorless.multiple([
                            Validatorless.required('Campo obrigatório'),
                            if (widget.module.type == ItemModuleCourseEnum.link)
                              Validatorless.regex(RegExp(r"(?:(?:https?):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+"), "Url inválida")
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
                                    Navigator.of(context).pop(BasicItemModuleCourseModel(
                                      title: titleEC.text,
                                      content: contentEC.text,
                                      type: widget.module.type,
                                    ));
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
