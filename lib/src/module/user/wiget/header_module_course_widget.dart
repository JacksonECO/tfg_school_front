import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/circle_button.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/module_course_model.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';

class HeaderModuleCourse extends StatelessWidget {
  final ModuleCourseModel module;
  final int subjectId;
  final CourseController controller;

  const HeaderModuleCourse({
    super.key,
    required this.controller,
    required this.subjectId,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Modular.get<AuthModel>();
    final TextEditingController titleEC =
        TextEditingController(text: module.title);
    final TextEditingController descriptionEC =
        TextEditingController(text: module.description);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                module.title,
                style: context.style.poppinsBold.copyWith(fontSize: 22),
              ),
            ),
            if (auth.role == AuthRoleEnum.teacher)
              Row(
                children: [
                  CircleButton(
                    color: context.colors.primary,
                    icon: Icons.keyboard_arrow_up,
                    onPressed: () async {
                      await controller.handleUpModule(
                          module.id, subjectId, module.ordenation);
                    },
                  ),
                  CircleButton(
                    color: context.colors.primary,
                    icon: Icons.keyboard_arrow_down,
                    onPressed: () async {
                      await controller.handleDownModule(
                          module.id, subjectId, module.ordenation);
                    },
                  ),
                  CircleButton(
                    color: context.colors.primary,
                    icon: Icons.create,
                    onPressed: () async {
                      if (await ModalAlert.showTitleContent(
                          title: 'Editar recurso: ${module.title}',
                          titleEC: titleEC,
                          contentEC: descriptionEC)) {
                        await controller.updateModule(
                            moduleId: module.id,
                            title: titleEC.text,
                            descripton: descriptionEC.text,
                            subjectId: subjectId);
                      }
                    },
                  ),
                  CircleButton(
                    color: context.colors.error,
                    icon: Icons.close,
                    onPressed: () async {
                      if (await ModalAlert.showConfirmRemove(
                          'Deseja remover o recurso: ${module.title}?')) {
                        await controller.deleteModule(module.id, subjectId);
                      }
                    },
                  ),
                ],
              ),
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Text(
          module.description,
          style: context.style.text,
        ),
      ],
    );
  }
}
