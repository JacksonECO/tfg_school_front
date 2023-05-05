import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/model/auth_model.dart';
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
  late String email = isSchool ? Constants.emailSchool : Constants.emailUser;
  late String password = Constants.password;

  Future<void> login() async {
    if (form.currentState!.validate()) {
      try {
        Map<String, dynamic>? user;
        if (isSchool) {
          user = await _service.loginSchool(email, password);
        } else {
          user = await _service.loginUser(email, password);
        }

        Modular.get<AuthModel>().set(AuthModel.fromMap(user!));

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
