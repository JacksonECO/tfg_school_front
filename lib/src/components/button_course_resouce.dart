import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/course_resource_option.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';

class ButtonCourseResouce extends StatelessWidget {
  final CourseResourceOption option;
  final CourseController controller;
  final int moduleId;

  const ButtonCourseResouce({super.key, required this.option, required this.controller, required this.moduleId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.of(context).pop(false);
        TextEditingController titleEC = TextEditingController();
        TextEditingController contentEC = TextEditingController();
        switch (option.type) {
          case 'text':
            if (await ModalAlert.showTitleContent(
              title: 'Recurso Texto',
              titleEC: titleEC,
              contentEC: contentEC,
              description: 'Conteúdo',
            )) {
              await controller.addResourceText(titleEC.text, contentEC.text, moduleId);
            }
            break;
          case 'file':
            break;
          case 'link':
            if (await ModalAlert.showTitleContent(
                title: 'Recurso Link', titleEC: titleEC, contentEC: contentEC, description: 'Link')) {
              await controller.addResourceLink(titleEC.text, contentEC.text, moduleId);
            }
            break;
          case 'quiz':
            break;
          case 'dissert':
            break;
          case 'fill-the-blanks':
            break;
        }
      },
      child: Container(
        width: context.height * 0.2,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: option.color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/${option.type}-resource.png',
              height: 40,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              option.title,
              style: context.style.text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
