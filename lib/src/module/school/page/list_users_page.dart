import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_user_widget.dart';

class ListUsersPage extends StatelessWidget {
  final ListUsersController controller;
  final Function({required bool isStudent, int? userId}) profileUserControllerType;
  const ListUsersPage({
    required this.controller,
    required this.profileUserControllerType,
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
                onChanged: controller.search,
                profileUserControllerType: profileUserControllerType,
                typeUser: controller.typeUser,
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

                  return Observer(builder: (_) {
                    return TableUserWidget(
                      controller: controller,
                      users: controller.users,
                      profileUserControllerType: profileUserControllerType,
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
