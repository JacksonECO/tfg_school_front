import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/click.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/controller/module_course_controller.dart';
import 'package:tfg_front/src/module/user/model/basic_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_enum.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_model.dart';
import 'package:tfg_front/src/module/user/widget/module_course_widget.dart';
import 'package:tfg_front/src/module/user/widget/resources/resource_basic_widget.dart';
import 'package:tfg_front/src/module/user/widget/resources/resource_quiz_widget.dart';

class ModulesCourseWidget extends StatelessWidget {
  final ModuleCouseController controller;
  final int index;

  const ModulesCourseWidget({
    required this.controller,
    required this.index,
    super.key,
  });

  ModuleCourseModel get module => controller.modules[index];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                module.title,
                style: context.style.poppinsBold.copyWith(fontSize: 22),
                maxLines: 2,
              ),
            ),
            if (controller.isProf) ...[
              const SizedBox(width: 12),
              IconButton.filled(
                icon: const Icon(Icons.keyboard_arrow_up),
                onPressed: () async {
                  await controller.moduleToUp(index);
                },
              ),
              const SizedBox(width: 6),
              IconButton.filled(
                icon: const Icon(Icons.keyboard_arrow_down),
                onPressed: () async {
                  await controller.moduleToDown(index);
                },
              ),
              const SizedBox(width: 6),
              IconButton.filled(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                icon: const Icon(Icons.create),
                onPressed: () async {
                  final module = await ModuleCourseWidget(module: controller.modules[index]).openModal(context);
                  if (module == null) return;

                  controller.edit(index, module);
                },
              ),
              const SizedBox(width: 6),
              IconButton.filled(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                icon: const Icon(Icons.close),
                onPressed: () => controller.delete(index),
              ),
            ]
          ],
        ),
        const Divider(
          thickness: 2,
        ),
        Flexible(
          child: SelectableText(
            module.description,
            style: context.style.text,
            textAlign: TextAlign.start,
          ),
        ),

        const SizedBox(height: 20),
        Observer(builder: (_) {
          return Column(
            children: controller.modules[index].content.map((item) {
              return item.type.tile(
                item: item,
                context: context,
                controller: controller,
                indexModule: index,
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 4),
        if (controller.isProf)
          Align(
            alignment: Alignment.topRight,
            child: Button(
              withBorder: false,
              height: 50,
              color: context.colors.primary,
              onPressed: () {
                showAddResource();
              },
              text: 'Adicionar Recurso',
            ),
          ),
        // ListView.builder(
        //   // physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   primary: false,
        //   itemCount: 1,
        //   itemBuilder: (context, widget.index) {
        //     return Text(widget.index.toString());
        //   },
        // ),
        const SizedBox(height: 45),
      ],
    );
  }

  Future<void> showAddResource() async {
    final type = await showDialog<ItemModuleCourseEnum>(
      context: Constants.context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: context.colors.secondary,
          titlePadding: const EdgeInsets.only(bottom: 40, left: 50, right: 50, top: 40),
          buttonPadding: const EdgeInsets.only(left: 8, right: 8),
          title: SelectableText(
            'Selecione o Recurso que deseja inserir',
            style: context.style.poppinsRegular.copyWith(fontSize: 28),
          ),
          actionsAlignment: MainAxisAlignment.center,
          content: SizedBox(
            width: 1,
            child: CustomScrollView(
              primary: false,
              shrinkWrap: true,
              slivers: <Widget>[
                SliverGrid.count(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  children: ItemModuleCourseEnum.values
                      .map(
                        (tipo) => Click(
                          child: Container(
                            width: 10,
                            height: 10,
                            padding: const EdgeInsets.all(25),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: tipo.color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(tipo.pathIcon, height: 40),
                                const SizedBox(height: 20),
                                Text(
                                  tipo.title,
                                  style: context.style.text,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          onTap: () => Navigator.of(context).pop(tipo),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (type == null) return;

    ItemModuleCourseModel? resource;

    switch (type) {
      case ItemModuleCourseEnum.text:
      case ItemModuleCourseEnum.link:
        resource = await ResourceBasicWidget(
          module: BasicItemModuleCourseModel(type: type),
        ).openModal(Constants.context);
        break;

      case ItemModuleCourseEnum.quiz:
        resource = await ResourceQuizWidget(
          module: QuizItemModuleCourseModel(type: type, quizzes: [QuizModel()], title: ''),
        ).openModal(Constants.context);
        break;

      default:
        ModalAlert.show('Em desenvolvimento', 'Ainda não foi implementado esse recurso');
    }

    if (resource == null) return;
    controller.addItem(index, resource);
  }
}
