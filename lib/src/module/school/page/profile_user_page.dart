import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_user_widget.dart';

class ProfileUserPage extends StatelessWidget {
  final ProfileUserController controller;
  const ProfileUserPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        Container(
          width: 850,
          margin: const EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ProfileUserWidget(controller: controller),
        ),
      ],
    );
  }
}
