import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/theme/custom_colors.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceModuleCourseItem extends StatelessWidget {
  final dynamic resource;
  final CourseController controller;

  const ResourceModuleCourseItem({
    super.key,
    required this.resource,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Modular.get<AuthModel>();
    Color color = CustomColors.i.primary;
    Function editFunction = () {};
    Function showFunction = () {};

    removeFunction() async {
      if (await ModalAlert.showConfirmRemove(
          'Deseja remover o recurso: ${resource.title}?')) {
        await controller.removeResource(resource);
      }
    }

    switch (resource.type) {
      case 'text':
        TextEditingController titleEC =
            TextEditingController(text: resource.title);
        TextEditingController contentEC =
            TextEditingController(text: resource.content);
        color = CustomColors.i.primary;
        editFunction = () async {
          if (await ModalAlert.showTitleContent(
              title: 'Recurso: ${resource.title}',
              titleEC: titleEC,
              contentEC: contentEC)) {
            await controller.updateResourceText(
                resource, titleEC.text, contentEC.text);
          }
        };
        showFunction = () async {
          if (await ModalAlert.showContent(
              title: '${resource.title}', content: resource.content)) {}
        };
        break;
      case 'file':
        color = CustomColors.i.primary;
        break;
      case 'link':
        TextEditingController titleEC =
            TextEditingController(text: resource.title);
        TextEditingController linkEC =
            TextEditingController(text: resource.link);
        color = CustomColors.i.primary;
        editFunction = () async {
          if (await ModalAlert.showTitleContent(
              title: 'Recurso: ${resource.title}',
              titleEC: titleEC,
              contentEC: linkEC)) {
            await controller.updateResourceLink(
                resource, titleEC.text, linkEC.text);
          }
        };
        showFunction = () async {
          if (!await launchUrl(Uri.parse(resource.link))) {
            throw Exception('Could not launch ${resource.link}');
          }
        };
        color = CustomColors.i.primary;
        break;
      case 'quiz':
        color = CustomColors.i.ternary;
        break;
      case 'dissert':
        color = CustomColors.i.ternary;
        break;
      case 'fill_the_blanks':
        color = CustomColors.i.ternary;
        break;
    }

    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              await showFunction();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Image.asset(
                      'assets/icon/${resource.type}-resource.png',
                      height: 30,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        resource.title,
                        style: context.style.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (auth.role == AuthRoleEnum.teacher)
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.create),
                onPressed: () async {
                  await editFunction();
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await removeFunction();
                },
              ),
            ],
          ),
      ],
    );
  }
}
