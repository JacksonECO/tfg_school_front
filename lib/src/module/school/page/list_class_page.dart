import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/model/class_with_subject_model.dart';
import 'package:tfg_front/src/module/school/controller/class_controller.dart';
import 'package:tfg_front/src/module/school/controller/list_class_controller.dart';
import 'package:tfg_front/src/module/school/widget/class_widget.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_class_widget.dart';

class ListClassPage extends StatelessWidget {
  final ListClassController controller;
  final ClassController Function({int? userId, ClassWithSubjectModel? userClass}) classController;

  const ListClassPage({super.key, required this.controller, required this.classController});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        CrudViewer(title: 'Turmas', body: [
          SearchSubHeaderWidget(
            title: 'Turma',
            onChanged: controller.search,
            onAdd: () async {
              await ClassWidget.showModal(classController: classController());
              controller.goTo(1);
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder<bool>(
            future: controller.future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: SelectableText('Não foi possível pegar as turmas'),
                );
              }

              return TableClassWidget(
                controller: controller,
                classControllerType: classController,
              );
            },
          ),
          const SizedBox(height: 16),
          Observer(builder: (_) {
            return Align(
              alignment: Alignment.center,
              child: PaginatorWidget(
                pagination: controller.pagination,
                goTo: controller.goTo,
              ),
            );
          }),
        ]),
      ],
    );
  }
}
