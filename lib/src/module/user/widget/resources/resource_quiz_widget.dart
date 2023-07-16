import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_text_styles.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_model.dart';
import 'package:validatorless/validatorless.dart';

class ResourceQuizWidget extends StatefulWidget {
  final QuizItemModuleCourseModel module;
  final bool onlyView;
  final bool isDoing;
  const ResourceQuizWidget({
    required this.module,
    this.onlyView = false,
    this.isDoing = false,
    super.key,
  });

  Future<QuizItemModuleCourseModel?> openModal(BuildContext context) async {
    final save = module.copyWith();
    final resp = await showDialog<QuizItemModuleCourseModel>(
      context: context,
      builder: (context) => this,
    );

    if (resp == null) {
      module.quizzes = save.quizzes;
      module.title = save.title;
    }
    return resp;
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
  State<ResourceQuizWidget> createState() => _ResourceQuizWidgetState();
}

class _ResourceQuizWidgetState extends State<ResourceQuizWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleEC = TextEditingController();

  @override
  void initState() {
    titleEC.text = widget.module.title;
    super.initState();
  }

  @override
  void dispose() {
    titleEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.secondary,
      titlePadding: const EdgeInsets.only(bottom: 10, left: 50, right: 50, top: 38),
      contentPadding: const EdgeInsets.only(left: 40, right: 15, bottom: 20),
      title: SelectableText(
        widget.module.type.title,
        style: context.style.poppinsRegular.copyWith(fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(right: 25),
            width: 700,
            child: Column(
              children: [
                InputRegister(
                  enabled: !widget.onlyView && !widget.isDoing,
                  title: 'Título',
                  hintText: 'Nome do recurso',
                  controller: titleEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Campo obrigatório'),
                    Validatorless.max(255, 'Nº máximo de caracteres ultrapassado')
                  ]),
                ),
                const SizedBox(height: 20),
                Observer(builder: (_) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        List.generate(widget.module.quizzes.length, (index) => oneQuiz(widget.module.quizzes[index], index)),
                  );
                }),
                if (!widget.onlyView && !widget.isDoing)
                  IconButton(
                    onPressed: () {
                      widget.module.quizzes.add(QuizModel(
                        question: '',
                        possibleSolution: ['', '', '', ''],
                        indexSolution: 0,
                      ));
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      size: 35,
                      color: Colors.green,
                    ),
                  ),
                if (!widget.onlyView) const SizedBox(height: 10),
                if (!widget.onlyView && !widget.isDoing)
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
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                if (widget.isDoing)
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          color: const Color(0xff6776ED),
                          text: 'Realizar entrega',
                          height: 50,
                          withBorder: false,
                          onPressed: () {
                            if (_formKey.currentState!.validate() && widget.module.isAnswered) {
                              Navigator.of(context).pop(widget.module.copyWith(
                                title: titleEC.text,
                              ));
                            } else {
                              ModalAlert.show(
                                'Incompleto',
                                "Responda todas as perguntas!",
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget oneQuiz(QuizModel quiz, int index) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: InputRegister(
                enabled: !widget.onlyView && !widget.isDoing,
                initialValue: quiz.question,
                title: 'Pergunta ${index + 1}',
                onChanged: (value) {
                  quiz.question = value;
                },
                validator: Validatorless.required('Campo obrigatório'),
              ),
            ),
            if (!widget.onlyView && !widget.isDoing)
              Padding(
                padding: const EdgeInsets.only(top: 35),
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.module.quizzes.removeAt(index);
                  },
                ),
              )
          ],
        ),
        ...List.generate(
          quiz.possibleSolution.length,
          (index) => Observer(
            builder: (_) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35, right: 10),
                    child: widget.onlyView && !widget.isDoing
                        ? Icon(
                            quiz.indexSolution == index ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                            color: Colors.white,
                          )
                        : Radio(
                            value: quiz.indexSolution,
                            groupValue: index,
                            onChanged: (v) {
                              quiz.indexSolution = index;
                            },
                          ),
                  ),
                  Flexible(
                    child: InputRegister(
                      enabled: !widget.onlyView && !widget.isDoing,
                      initialValue: quiz.possibleSolution[index],
                      title: 'Alternativa ${String.fromCharCode(65 + index)}',
                      onChanged: (value) {
                        quiz.possibleSolution[index] = value;
                      },
                      validator: Validatorless.required('Campo obrigatório'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
