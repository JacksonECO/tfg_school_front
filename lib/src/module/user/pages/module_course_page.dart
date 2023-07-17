import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/menu_floating_item.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/module/user/controller/module_course_controller.dart';
import 'package:tfg_front/src/module/user/controller/news_controller.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';
import 'package:tfg_front/src/module/user/widget/modal_news_widget.dart';
import 'package:tfg_front/src/module/user/widget/module_course_widget.dart';
import 'package:tfg_front/src/module/user/widget/modules_course_widget.dart';

class ModuleCousePage extends StatefulWidget {
  final ModuleCouseController? controller;
  final SubjectModel subject;
  const ModuleCousePage({
    required this.subject,
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
    controller.subject = widget.subject;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colors.primary,
        shape: const CircleBorder(),
        child: const Icon(Icons.more_vert),
        onPressed: () {
          showFloatingMenu();
        },
      ),
      body: [
        CrudViewer(
          title: widget.subject.name ?? '',
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
        subjectId: widget.subject.id!,
        order: controller.modules.length + 1,
        content: [],
      ),
    ).openModal(context);

    if (newModule == null) return;
    controller.addModule(newModule);
  }

  Future showFloatingMenu() {
    final itens = [
      MenuFloatingItem(
        title: 'Notícias',
        iconPath: 'assets/icon/alert-dark.png',
        handleShow: () async {
          final NewsController newsController = NewsController();
          await newsController.loadNews(controller.subject!);
          ModalNewsWidget().showNews(context, newsController.allNews[0].news!);
        },
      ),
      if (controller.isProf)
        MenuFloatingItem(
          title: 'Lista de Presença',
          iconPath: 'assets/icon/class.png',
          handleShow: () async {
            Navigator.of(context).pushNamed('/user/attendance/${controller.subject!.classId}/${controller.subject!.id}');
          },
        )
    ];

    return showDialog(
      context: Constants.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.bottomRight,
          insetPadding: const EdgeInsets.fromLTRB(0, 0, 20, 80),
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200, minHeight: 60),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: itens.map((item) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          item.handleShow();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Row(
                            children: [
                              Image.asset(
                                item.iconPath,
                                height: 24,
                                width: 24,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                item.title,
                                style: context.style.poppinsMedium.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
