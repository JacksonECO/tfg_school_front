import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';

class ListUsersPage extends StatelessWidget {
  final ListUsersController controller;
  const ListUsersPage({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(50.0),
          padding: const EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          constraints: const BoxConstraints(minWidth: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchSubHeaderWidget(
                title: 'Alunos',
                onChanged: controller.search,
              ),
              const SizedBox(height: 16),
              FutureBuilder<bool>(
                future: controller.future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Não foi possível pegar os alunos'),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Observer(builder: (_) {
                    return TableUser(
                      users: controller.users,
                    );
                  });
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
              })
            ],
          ),
        ),
      ],
    );
  }
}

extension ListExtension<T> on List<T> {
  T? index(int index) {
    if (length <= index) {
      return null;
    }
    return this[index];
  }
}

class TableUser extends StatelessWidget {
  final List<UserModel> users;
  const TableUser({super.key, required this.users});

  List<int> get listHelp => List.generate(max(users.length, 10), (index) => index, growable: false);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(4),
        2: FlexColumnWidth(1.5),
        3: IntrinsicColumnWidth(flex: 0.5),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: context.colors.blue,
          ),
          children: const [
            TableText('Nome', isHeader: true),
            TableText('Email', isHeader: true),
            TableText('Turma', isHeader: true),
            TableText('Ações', isHeader: true),
          ],
        ),
        ...listHelp.map(
          (index) => TableRow(
            decoration: BoxDecoration(
              color: index.isEven ? context.colors.backgroundPrimary : const Color(0xFF424162),
            ),
            children: [
              TableText(users.index(index)?.name ?? ''),
              TableText(users.index(index)?.email ?? ''),
              TableText(users.index(index)?.classId?.toString() ?? ''),
              users.index(index)?.id == null
                  ? const TableText('')
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
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

class TableText extends StatelessWidget {
  final String text;
  final bool isHeader;
  const TableText(
    this.text, {
    this.isHeader = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      constraints: const BoxConstraints(minHeight: 50),
      alignment: isHeader ? Alignment.center : Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
