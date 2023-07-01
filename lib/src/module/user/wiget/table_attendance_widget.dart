import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/helpers/date_time_extension.dart';
import 'package:tfg_front/src/core/helpers/list_extension.dart';
import 'package:tfg_front/src/module/school/widget/table_text_widget.dart';
import 'package:tfg_front/src/module/user/controller/attendance_controller.dart';
import 'package:tfg_front/src/module/user/controller/list_attendance_controller.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/wiget/attendance_widget.dart';

class TableAttendanceWidget extends StatefulWidget {
  final ListAttendanceController controller;
  final AttendanceController Function({
    required int subjectId,
    required int classId,
    int? attendanceId,
    AttendanceModel? attendanceModel,
  }) attendanceController;

  const TableAttendanceWidget({
    required this.controller,
    required this.attendanceController,
    super.key,
  });

  @override
  State<TableAttendanceWidget> createState() => _TableAttendanceWidgetState();
}

class _TableAttendanceWidgetState extends State<TableAttendanceWidget> {
  List<int> get listHelp =>
      List.generate(max(widget.controller.data.length, 10), (index) => index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: [
        const FlexColumnWidth(2),
        const FlexColumnWidth(),
        const FlexColumnWidth(),
        const FlexColumnWidth(),
        const FlexColumnWidth(),
        const FixedColumnWidth(100),
      ].asMap(),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: context.colors.blue,
          ),
          children: const [
            TableTextWidget('Dia', isHeader: true),
            TableTextWidget('Total de Aulas', isHeader: true),
            TableTextWidget('Total de Presentes', isHeader: true),
            TableTextWidget('Total de Faltantes', isHeader: true),
            TableTextWidget(''),
            TableTextWidget('Editar', isHeader: true),
          ],
        ),
        ...listHelp.map(
          (index) => TableRow(
            decoration: BoxDecoration(
              color: index.isEven ? context.colors.backgroundPrimary : const Color(0xFF424162),
            ),
            children: [
              Observer(builder: (_) {
                return TableTextWidget(widget.controller.data.index(index)?.date?.date ?? '');
              }),
              Observer(builder: (_) {
                return TableTextWidget(
                    widget.controller.data.index(index)?.totalLesson.toString() ?? '');
              }),
              Observer(builder: (_) {
                return TableTextWidget(
                    widget.controller.data.index(index)?.totalPresent.toString() ?? '');
              }),
              Observer(builder: (_) {
                return TableTextWidget(
                    widget.controller.data.index(index)?.totalAbsent.toString() ?? '');
              }),
              const SizedBox(),
              widget.controller.data.index(index)?.id == null
                  ? const TableTextWidget('')
                  : IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        var elementController = widget.attendanceController(
                          subjectId: widget.controller.subjectId,
                          classId: widget.controller.classId,
                          attendanceModel: widget.controller.data.index(index)?.copyWith(),
                        );

                        if ((await AttendanceWidget.showModal(
                                attendanceController: elementController)) ==
                            true) {
                          widget.controller.data[index].users =
                              elementController.attendanceModel.users;

                          widget.controller.data[index].date =
                              elementController.attendanceModel.date;

                          widget.controller.data[index].totalLesson =
                              elementController.attendanceModel.totalLesson;
                        }
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
