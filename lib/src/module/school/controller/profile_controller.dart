import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';
import 'package:tfg_front/src/module/school/service/login_service.dart';

class ProfileController {
  final SchoolProfileService _service = Modular.get<SchoolProfileService>();

  ProfileController({
    this.newSchool = true,
  });

  final SchoolModel school = SchoolModel.clean();
  final bool newSchool;
  final form = GlobalKey<FormState>();

  String? verifyPassword(String? confirmPassword) {
    if (school.password != confirmPassword) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> register() async {
    try {
      if (form.currentState!.validate()) {
        await _service.register(school);
        // Modular.to.navigate('/school/login');
        ModalAlert.show(
          'Cadastro',
          "Escola registrada com sucesso!",
        );
      }
    } on CustomException catch (e) {
      ModalAlert.show(
        'Cadastro',
        e.message,
      );
    } catch (_) {
      ModalAlert.show(
        'Cadastro',
        "Falha ao registrar escola!",
      );
    }
  }
}
