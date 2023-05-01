import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_user_widget.dart';

class ProfileUserPage extends StatelessWidget {
  final ProfileUserController controller;
  const ProfileUserPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        ProfileUserWidget(controller: controller),
      ],
    );
  }
}
