import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/controller/module_course_controller.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';
import 'package:tfg_front/src/module/user/widget/module_course_widget.dart';
import 'package:tfg_front/src/module/user/widget/modules_course_widget.dart';

class ModuleCousePage extends StatefulWidget {
  final ModuleCouseController? controller;
  final int subjectId;
  final String subjectName;
  const ModuleCousePage({
    required this.subjectId,
    required this.subjectName,
    this.controller,
    super.key,
  });

  @override
  State<ModuleCousePage> createState() => _ModuleCousePageState();
}

class _ModuleCousePageState extends State<ModuleCousePage> {
  late final ModuleCouseController controller;

  @override
  void initState() {
    controller = widget.controller ?? Modular.get<ModuleCouseController>();
    controller.subjectId = widget.subjectId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        CrudViewer(
          title: widget.subjectName,
          hasScroll: true,
          body: [
            FutureBuilder(
              future: controller.future,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Erro ao carregar os módulos'));
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(backgroundColor: Colors.white),
                  );
                }

                return Observer(builder: (_) {
                  if (controller.modules.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: context.height * 0.2),
                        const Center(child: Text('Sem módulos cadastrados')),
                        SizedBox(height: context.height * 0.05),
                        if (controller.isProf)
                          Button.green(
                            width: 400,
                            text: 'Adicionar primeiro módulo',
                            onPressed: () => showAddModule(context),
                          ),
                      ],
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          controller.modules.length,
                          (index) => ModulesCourseWidget(
                            key: ValueKey(index),
                            index: index,
                            controller: controller,
                          ),
                        ),
                        if (controller.isProf)
                          IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              size: 35,
                              color: context.colors.green,
                            ),
                            onPressed: () => showAddModule(context),
                          ),
                      ],
                    ),
                  );
                });

                // return ListView.builder(
                //   shrinkWrap: true,
                //   primary: false,
                //   // physics: const NeverScrollableScrollPhysics(),
                //   itemCount: controller.modules.length,
                //   itemBuilder: (context, index) {
                //     return ModuleCourseWidget(
                //       index: index,
                //       controller: controller,
                //     );
                //   },
                // );
              },
            )
          ],
        ),
      ],
    );
  }

  Future<void> showAddModule(BuildContext context) async {
    final newModule = await ModuleCourseWidget(
      module: ModuleCourseModel(
        title: '',
        description: '',
        subjectId: widget.subjectId,
        order: controller.modules.length + 1,
        content: [],
      ),
    ).openModal(context);

    if (newModule == null) return;
    controller.addModule(newModule);
  }
}
