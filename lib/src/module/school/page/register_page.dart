import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:tfg_front/src/module/school/widget/profile_widget.dart';

class RegisterPage extends StatelessWidget {
  final ProfileController controller;
  const RegisterPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        ProfileWidget(controller: controller),
      ],
    );
  }
}
