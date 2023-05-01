import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';

import 'package:tfg_front/src/service/login_service.dart';

class LoginController {
  final LoginService _service = Modular.get<LoginService>();

  LoginController({
    required this.isSchool,
  });

  final bool isSchool;

  final form = GlobalKey<FormState>();
  String email = '';
  String password = '';

  Future<void> login() async {
    if (form.currentState!.validate()) {
      try {
        if (isSchool) {
          await _service.loginSchool(email, password);
        } else {
          await _service.loginUser(email, password);
        }
        Modular.to.pushReplacementNamed(
          isSchool ? SchoolModule.initialRoute : UserModule.initialRoute,
        );
      } on CustomException catch (e) {
        ModalAlert.show('Login', e.message);
      } catch (e) {
        ModalAlert.show('Login', 'Erro ao fazer login, tente mais tarde.');
      }
    }
  }

  Future<void> register() async {
    Modular.to.pushNamed(
      isSchool ? SchoolModule.registerRoute : UserModule.registerRoute,
    );
  }

  void switchTypeAccount() {
    Modular.to.pushReplacementNamed(
      isSchool ? HomeModule.loginUserRoute : HomeModule.loginSchoolRoute,
    );
  }

  void forgotPassword() {}
}
