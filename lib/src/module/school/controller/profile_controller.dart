import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';
import 'package:tfg_front/src/module/school/school_module.dart';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/service/login_service.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final LoginService _service = Modular.get<LoginService>();
  final ImagePicker _imagePicker = Modular.get<ImagePicker>();

  _ProfileControllerBase({
    this.newSchool = true,
  });

  SchoolModel school = SchoolModel.clean();
  final bool newSchool;
  final form = GlobalKey<FormState>();
  bool hasDate = false;

  @observable
  FileModel? image;

  Future<bool> get getSchool async {
    if (hasDate) return true;

    final temp = await _service.getSchool();
    school = temp;

    return hasDate = true;
  }

  String? verifyPassword(String? confirmPassword) {
    if (school.password != confirmPassword) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> register() async {
    try {
      if (form.currentState!.validate()) {
        final AuthModel auth = await _service.registerSchool(school, image);
        await ModalAlert.show(
          'Cadastro',
          "Escola registrada com sucesso!",
        );

        Modular.get<AuthModel>().set(auth);
        Modular.to.navigate(SchoolModule.initialRoute);
      }
    } on CustomException catch (e) {
      ModalAlert.show(
        'Cadastro',
        e.message,
      );
    } catch (e, s) {
      log('Erro ao registrar escola', error: e, stackTrace: s);
      ModalAlert.show(
        'Cadastro',
        "Falha ao registrar escola!",
      );
    }
  }

  Future<void> getImage() async {
    try {
      final XFile? imgFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        requestFullMetadata: false,

        // TODO: Definir compressão de imagem
        maxHeight: 250,
        // maxWidth: dimension,
        // imageQuality: 75,
      );

      if (imgFile == null) {
        throw CustomException(message: 'Operação Cancelada');
      }

      image = await FileModel.fromPicker(imgFile);
    } on CustomException catch (_) {
    } catch (e, s) {
      log('Erro ao buscar Imagem', error: e, stackTrace: s);
      ModalAlert.show(
        'Logotipo',
        "Falha ao pegar imagem!",
      );
    }
  }
}
