import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/helpers/list_extension.dart';
import 'package:tfg_front/src/model/class_with_subject_model.dart';
import 'package:tfg_front/src/module/school/controller/class_controller.dart';
import 'package:tfg_front/src/module/school/controller/list_class_controller.dart';
import 'package:tfg_front/src/module/school/widget/class_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_text_widget.dart';

class TableClassWidget extends StatefulWidget {
  final ListClassController controller;
  final ClassController Function({int? userId, ClassWithSubjectModel? userClass})
      classControllerType;

  const TableClassWidget({
    required this.controller,
    required this.classControllerType,
    super.key,
  });

  @override
  State<TableClassWidget> createState() => _TableClassWidgetState();
}

class _TableClassWidgetState extends State<TableClassWidget> {
  List<int> get listHelp =>
      List.generate(max(widget.controller.data.length, 10), (index) => index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: [const FlexColumnWidth(), const FixedColumnWidth(100)].asMap(),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: context.colors.blue,
            ),
            children: const [
              TableTextWidget('Nome', isHeader: true),
              TableTextWidget('Ações', isHeader: true),
            ],
          ),
          ...listHelp.map(
            (index) => TableRow(
              decoration: BoxDecoration(
                color: index.isEven ? context.colors.backgroundPrimary : const Color(0xFF424162),
              ),
              children: [
                Observer(
                    builder: (_) =>
                        TableTextWidget(widget.controller.data.index(index)?.name ?? '')),
                widget.controller.data.index(index)?.id == null
                    ? const TableTextWidget('')
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              var elementController = widget.classControllerType(
                                userId: widget.controller.data.index(index)?.id,
                              );
                              await ClassWidget.showModal(
                                classController: elementController,
                              );
                              setState(() {});
                              widget.controller.data[index].name =
                                  elementController.classModel.name;
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              if (await ModalAlert.showConfirmRemove(
                                'Deseja excluir a Turma: ${widget.controller.data.index(index)?.name}',
                              )) {
                                await widget.controller.remove(index);
                                setState(() {});
                              }
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
