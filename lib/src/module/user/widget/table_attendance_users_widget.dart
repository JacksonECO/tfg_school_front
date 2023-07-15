import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/widget/table_text_widget.dart';
import 'package:tfg_front/src/module/user/controller/attendance_controller.dart';
import 'package:tfg_front/src/core/helpers/list_extension.dart';

class TableAttendanceUsersWidget extends StatefulWidget {
  final AttendanceController controller;

  const TableAttendanceUsersWidget({
    required this.controller,
    super.key,
  });

  @override
  State<TableAttendanceUsersWidget> createState() => _TableAttendanceUsersWidgetState();
}

class _TableAttendanceUsersWidgetState extends State<TableAttendanceUsersWidget> {
  List<int> get listHelp => List.generate(
        widget.controller.attendanceModel.users.length,
        (index) => index,
        growable: false,
      );

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: [
        const FlexColumnWidth(),
        const FlexColumnWidth(),
        const FlexColumnWidth(),
        const FlexColumnWidth(),
      ].asMap(),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: context.colors.blue,
          ),
          children: [
            const TableTextWidget('Nome', isHeader: true),
            const TableTextWidget('Matrícula', isHeader: true),
            TableRowWidget(
              alignment: Alignment.center,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Radio(
                      value: widget.controller.allPresent,
                      groupValue: true,
                      onChanged: (v) {
                        if (v == null) return;
                        widget.controller.setAllPresent();
                      },
                    );
                  }),
                  const SizedBox(width: 8),
                  const SelectableText('Presença'),
                ],
              ),
            ),
            TableRowWidget(
              alignment: Alignment.center,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Radio(
                      value: widget.controller.allAbsent,
                      groupValue: false,
                      onChanged: (v) {
                        if (v == null) return;
                        widget.controller.setAllAbsent();
                      },
                    );
                  }),
                  const SizedBox(width: 8),
                  const SelectableText('Falta'),
                ],
              ),
            ),
          ],
        ),
        ...listHelp.map(
          (index) => TableRow(
            decoration: BoxDecoration(
              color: index.isEven ? context.colors.backgroundPrimary : const Color(0xFF424162),
            ),
            children: [
              TableTextWidget(
                widget.controller.attendanceModel.users.index(index)?.userName ?? '',
              ),
              TableTextWidget(
                widget.controller.attendanceModel.users.index(index)?.userRegistration ?? '',
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Radio(
                      value: '$index-${widget.controller.attendanceModel.users[index].isPresent}',
                      groupValue: '$index-true',
                      onChanged: (v) {
                        if (v == null) return;

                        bool? value = v.split('-').last == 'true' ? true : false;
                        widget.controller.attendanceModel.users[index].isPresent = !value;
                      },
                    );
                  }),
                  const SizedBox(width: 8),
                  const SelectableText('Presença'),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) {
                    return Radio(
                      value: '$index-${widget.controller.attendanceModel.users[index].isPresent}',
                      groupValue: '$index-false',
                      onChanged: (v) {
                        if (v == null) return;

                        bool? value = v.split('-').last == 'true' ? true : false;
                        widget.controller.attendanceModel.users[index].isPresent = !value;
                      },
                    );
                  }),
                  const SizedBox(width: 8),
                  const SelectableText('Falta'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
