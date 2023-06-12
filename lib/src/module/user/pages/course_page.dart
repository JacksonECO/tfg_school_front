import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/components/not_found.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/user/wiget/header_module_course_widget.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:tfg_front/src/module/user/wiget/resource_module_course_item.dart';

class CoursePage extends StatefulWidget {
  final int subjectId;

  const CoursePage({super.key, required this.subjectId});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  late final ReactionDisposer statusDisposer;
  final controller = Modular.get<CourseController>();
  final TextEditingController titleModuleEC = TextEditingController();
  final TextEditingController descriptionModuleEC = TextEditingController();
  final auth = Modular.get<AuthModel>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      statusDisposer = reaction((_) => controller.status, (status) {
        setState(() {});
      });
      await controller.loadSubject(widget.subjectId);
      await controller.loadModules(widget.subjectId);
    });
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> constructWidgets() {
      List<Widget> listModuleWidgets = [];
      int index = 0;
      for (var module in controller.modulesCourse) {
        listModuleWidgets.add(HeaderModuleCourse(
          module: module,
          controller: controller,
          subjectId: widget.subjectId,
        ));
        for (var resource in controller.resources) {
          if (resource.moduleId == module.id) {
            listModuleWidgets.add(ResourceModuleCourseItem(resource: resource, controller: controller));
          }
        }
        if (auth.role == AuthRoleEnum.teacher) {
          listModuleWidgets.add(Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 200,
              child: Button.blue(
                text: 'Adicionar Recurso',
                onPressed: () async {
                  await ModalAlert.showAddResouce(module.id, controller);
                },
              ),
            ),
          ),
        ));
        }
        if (index != controller.modulesCourse.length - 1) {
          listModuleWidgets.add(const SizedBox(
            height: 50,
          ));
        }
        index++;
      }
      if (auth.role == AuthRoleEnum.teacher) {
        listModuleWidgets.add(Container(
        width: 200,
        margin: const EdgeInsets.only(top: 20),
        child: Button.green(
          text: 'Adicionar Módulo',
          onPressed: () async {
            if (await ModalAlert.showTitleContent(
              title: 'Criar Módulo',
              titleEC: titleModuleEC,
              contentEC: descriptionModuleEC,
            )) {
              await controller.createModule(titleModuleEC.text,
                  descriptionModuleEC.text, widget.subjectId);
              titleModuleEC.clear();
              descriptionModuleEC.clear();
            }
          },
        ),
      ));
      }
      return listModuleWidgets;
    }

    return CustomPage(
      showFloatingButton: true,
      body: [
        controller.status == CourseStateStatus.loading
            ? (Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: context.colors.primary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Buscando Cursos...',
                      style: context.style.poppinsMedium,
                    ),
                  ),
                ],
              ))
            : controller.subject == null
                ? const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NotFound(),
                      ],
                    ),
                  )
                : CrudViewer(
                    title: controller.subject!.name!,
                    body: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...constructWidgets(),
                        ],
                      ),
                    ],
                  ),
      ],
    );
  }
}
