import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/paginator_widget.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_user_widget.dart';
import 'package:tfg_front/src/module/school/widget/search_sub_header_widget.dart';
import 'package:tfg_front/src/module/school/widget/table_user_widget.dart';

class ListUsersPage extends StatelessWidget {
  final ListUsersController controller;
  final ProfileUserController Function({required bool isStudent, int? userId})
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
        CrudViewer(
          title: controller.typeUser == AuthRoleEnum.student ? 'Alunos' : 'Professores',
          body: [
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(minWidth: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SearchSubHeaderWidget(
                    title: controller.typeUser == AuthRoleEnum.student ? 'Aluno' : 'Professor',
                    onChanged: controller.search,
                    onAdd: () {
                      ProfileUserWidget.showModal(
                        profileUserController: profileUserControllerType(
                          isStudent: controller.typeUser == AuthRoleEnum.student,
                        ),
                      );
                    },
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
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
