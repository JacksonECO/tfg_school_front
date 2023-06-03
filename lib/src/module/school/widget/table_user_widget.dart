import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/helpers/list_extension.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_user_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_text_widget.dart';

class TableUserWidget extends StatelessWidget {
  final ListUsersController controller;
  final List<UserModel> users;
  final Function({required bool isStudent, int? userId}) profileUserControllerType;

  const TableUserWidget({
    required this.users,
    required this.controller,
    required this.profileUserControllerType,
    super.key,
  });

  List<int> get listHelp => List.generate(max(users.length, 10), (index) => index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: [
        const FlexColumnWidth(3),
        const FlexColumnWidth(4),
        if (controller.typeUser == AuthRoleEnum.student) const FlexColumnWidth(2),
        if (controller.typeUser == AuthRoleEnum.student) const FlexColumnWidth(1.5),
        const IntrinsicColumnWidth(flex: 0.5)
      ].asMap(),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: context.colors.blue,
          ),
          children: [
            const TableTextWidget('Nome', isHeader: true),
            const TableTextWidget('Email', isHeader: true),
            if (controller.typeUser == AuthRoleEnum.student)
              const TableTextWidget('Matrícula', isHeader: true),
            if (controller.typeUser == AuthRoleEnum.student)
              const TableTextWidget('Turma', isHeader: true),
            const TableTextWidget('Ações', isHeader: true),
          ],
        ),
        ...listHelp.map(
          (index) => TableRow(
            decoration: BoxDecoration(
              color: index.isEven ? context.colors.backgroundPrimary : const Color(0xFF424162),
            ),
            children: [
              TableTextWidget(users.index(index)?.name ?? ''),
              TableTextWidget(users.index(index)?.email ?? ''),
              if (controller.typeUser == AuthRoleEnum.student)
                TableTextWidget(users.index(index)?.registration ?? ''),
              if (controller.typeUser == AuthRoleEnum.student)
                TableTextWidget(
                  users.index(index)?.className ?? users.index(index)?.classId?.toString() ?? '',
                ),
              users.index(index)?.id == null
                  ? const TableTextWidget('')
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            ProfileUserWidget.showModal(
                              profileUserController: profileUserControllerType(
                                isStudent: controller.typeUser == AuthRoleEnum.student,
                                userId: users.index(index)!.id!,
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            if (await ModalAlert.showConfirmRemove(
                              'Deseja excluir o(a) ${controller.typeUser == AuthRoleEnum.student ? 'aluno(a)' : 'professor(a)'} ${users.index(index)?.name ?? ''}?',
                            )) {
                              await controller.removeUser(users.index(index)?.id ?? 0);
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
  }
}
