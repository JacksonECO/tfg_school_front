import 'package:flutter/material.dart';

import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/button_course_resouce.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/src/model/course_resource_option.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:validatorless/validatorless.dart';

class ModalAlert {
  static Future<void> show(String title, String message) {
    return showDialog<void>(
      context: Constants.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SelectableText(title),
          content: SelectableText(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showConfirmRemove(String title) async {
    return await showDialog<bool>(
          context: Constants.context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(80),
              child: AlertDialog(
                backgroundColor: context.colors.secondary,
                titlePadding: const EdgeInsets.only(bottom: 38, left: 50, right: 50, top: 38),
                buttonPadding: const EdgeInsets.only(left: 8, right: 8),
                title: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: SelectableText(
                    title,
                    style: context.style.poppinsRegular.copyWith(fontSize: 24),
                  ),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  Button(
                    color: const Color(0xffFF3B3B),
                    text: 'Cancelar',
                    height: 50,
                    withBorder: false,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  Button(
                    color: const Color(0xff6776ED),
                    text: 'Confirmar',
                    height: 50,
                    withBorder: false,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;
  }

  static Future<bool> showContent({required String title, required String content, String? description = 'Descrição'}) async {
    return await showDialog<bool>(
          context: Constants.context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(minWidth: 400, maxWidth: 500),
              padding: const EdgeInsets.all(80),
              child: AlertDialog(
                backgroundColor: context.colors.secondary,
                titlePadding: const EdgeInsets.only(bottom: 38, left: 50, right: 50, top: 38),
                buttonPadding: const EdgeInsets.only(left: 8, right: 8),
                title: SelectableText(
                  title,
                  style: context.style.poppinsRegular.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: SizedBox(
                          width: context.width * 0.45,
                          child: SelectableText(
                            content,
                            style: context.style.text,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ) ??
        false;
  }

  static void formSubmit(BuildContext context, GlobalKey<FormState> formKey) {
    final formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      Navigator.of(context).pop(true);
    }
  }

  static Future<bool> showTitleContent(
      {required String title,
      required TextEditingController titleEC,
      required TextEditingController contentEC,
      String? description = 'Descrição'}) async {
    final formKey = GlobalKey<FormState>();
    return await showDialog<bool>(
          context: Constants.context,
          builder: (BuildContext context) {
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
                    title,
                    style: context.style.poppinsRegular.copyWith(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: [
                  Form(
                    key: formKey,
                    child: SizedBox(
                      width: 700,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.max(255, 'Nº máximo de caracteres ultrapassado')
                            ]),
                            decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              disabledBorder: border,
                              hintText: 'Título',
                              fillColor: context.colors.inputAlertModal,
                              filled: true,
                              hintStyle: context.style.poppinsRegular,
                              labelText: "Título*",
                              labelStyle: context.style.text,
                            ),
                            style: context.style.poppinsRegular,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: contentEC,
                            minLines: 1,
                            maxLines: 8,
                            validator: Validatorless.required('Campo obrigatório'),
                            decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              disabledBorder: border,
                              hintText: description,
                              labelText: '$description*',
                              labelStyle: context.style.text,
                              fillColor: context.colors.inputAlertModal,
                              filled: true,
                              hintStyle: context.style.poppinsRegular,
                              contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                            ),
                            style: context.style.poppinsRegular,
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
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Button(
                                    color: const Color(0xff6776ED),
                                    text: 'Confirmar',
                                    height: 50,
                                    withBorder: false,
                                    onPressed: () => formSubmit(context, formKey)),
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
          },
        ) ??
        false;
  }

  static Future<bool> showAddResouce(int moduleId, CourseController controller) async {
    List<CourseResourceOption> options = [
      CourseResourceOption(
        type: 'text',
        title: "Texto",
        color: const Color(0xff6776ED),
      ),
      CourseResourceOption(
        type: 'file',
        title: "Arquivo",
        color: const Color(0xff6776ED),
      ),
      CourseResourceOption(
        type: 'link',
        title: "Link",
        color: const Color(0xff6776ED),
      ),
      CourseResourceOption(
        type: 'quiz',
        title: "Questionário",
        color: const Color(0xff00CFDD),
      ),
      CourseResourceOption(
        type: 'dissert',
        title: "Dissertação",
        color: const Color(0xff00CFDD),
      ),
      CourseResourceOption(
        type: 'fill-the-blanks',
        title: "Preencha os Espaços",
        color: const Color(0xff00CFDD),
      ),
    ];
    return await showDialog<bool>(
          context: Constants.context,
          builder: (BuildContext context) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: AlertDialog(
                backgroundColor: context.colors.secondary,
                titlePadding: const EdgeInsets.only(bottom: 40, left: 50, right: 50, top: 40),
                buttonPadding: const EdgeInsets.only(left: 8, right: 8),
                title: SelectableText(
                  'Selecione o Resurso que deseja inserir',
                  style: context.style.poppinsRegular.copyWith(fontSize: 28),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  SizedBox(
                    width: 500,
                    height: 400,
                    child: CustomScrollView(
                      primary: false,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(5),
                          sliver: SliverGrid.count(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 3,
                            children: <Widget>[
                              ...options.map((e) => ButtonCourseResource(
                                    option: e,
                                    controller: controller,
                                    moduleId: moduleId,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ) ??
        false;
  }

  static OutlineInputBorder get border => ThemeConfig.border.copyWith(borderRadius: BorderRadius.circular(8));
}
