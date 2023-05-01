import 'package:flutter/material.dart';
import 'package:tfg_front/src/module/home/controller/login_controller.dart';
import 'package:tfg_front/src/module/home/widget/login_widget.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;
  const LoginPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: LoginWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
