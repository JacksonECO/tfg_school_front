import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';
import 'package:tfg_front/src/module/school/service/login_service.dart';

import 'package:mobx/mobx.dart';
part 'profile_controller.g.dart';

class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final SchoolProfileService _service = Modular.get<SchoolProfileService>();
  final ImagePicker _imagePicker = Modular.get<ImagePicker>();

  _ProfileControllerBase({
    this.newSchool = true,
  });

  final SchoolModel school = SchoolModel.clean();
  final bool newSchool;
  final form = GlobalKey<FormState>();

  @observable
  FileModel? image;

  String? verifyPassword(String? confirmPassword) {
    if (school.password != confirmPassword) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> register() async {
    try {
      if (form.currentState!.validate()) {
        await _service.register(school, image);
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
