import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_user_widget.dart';

class ListUsersPage extends StatelessWidget {
  final ListUsersController controller;
  final Function({required bool isStudent, int? userId})
      profileUserControllerType;
  const ListUsersPage({
    required this.controller,
    required this.profileUserControllerType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50.0,
                  left: 50.0,
                ),
                decoration: BoxDecoration(
                  color: context.colors.blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
                child: Text(controller.typeUser == AuthRoleEnum.student ? 'Alunos' : 'Professores'),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 50.0),
              padding: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
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

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
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
        ),
      ],
    );
  }
}
