import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/module/user/controller/attendance_controller.dart';
import 'package:tfg_front/src/module/user/controller/list_attendance_controller.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/widget/attendance_widget.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';
import 'package:tfg_front/src/module/user/widget/table_attendance_widget.dart';

class ListAttendancePage extends StatelessWidget {
  final ListAttendanceController controller;

  final AttendanceController Function({
    required int subjectId,
    required int classId,
    int? attendanceId,
    AttendanceModel? attendanceModel,
  }) attendanceController;

  const ListAttendancePage({
    required this.controller,
    required this.attendanceController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        CrudViewer(title: 'Lista de Presença', body: [
          SearchSubHeaderWidget(
            title: 'Aula',
            onAdd: () async {
              if (await AttendanceWidget.showModal(
                    attendanceController: attendanceController(
                      classId: controller.classId,
                      subjectId: controller.subjectId,
                    ),
                  ) ==
                  true) {
                controller.goTo(1);
              }
            },
          ),
          const SizedBox(height: 16),
          FutureBuilder<bool>(
            future: controller.future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: SelectableText('Não foi possível carregar a página'),
                );
              }

              return TableAttendanceWidget(
                controller: controller,
                attendanceController: attendanceController,
              );
            },
          ),
          const SizedBox(height: 16),
          Observer(
            warnWhenNoObservables: false,
            builder: (_) {
              return Align(
                alignment: Alignment.center,
                child: PaginatorWidget(
                  pagination: controller.pagination,
                  goTo: controller.goTo,
                ),
              );
            },
          ),
        ]),
      ],
    );
  }
}
