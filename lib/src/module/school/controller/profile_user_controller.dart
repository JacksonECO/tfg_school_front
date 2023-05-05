import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/module/school/model/class_model.dart';
import 'package:tfg_front/src/module/school/school_module.dart';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/service/class_service.dart';
import 'package:tfg_front/src/service/login_service.dart';
import 'package:tfg_front/src/service/user_service.dart';
part 'profile_user_controller.g.dart';

class ProfileUserController = _ProfileUserControllerBase with _$ProfileUserController;

abstract class _ProfileUserControllerBase with Store {
  final _service = Modular.get<LoginService>();
  final _serviceUser = Modular.get<UserService>();
  final _serviceSchool = Modular.get<ClassService>();
  final ImagePicker _imagePicker = Modular.get<ImagePicker>();

  _ProfileUserControllerBase({
    required this.isStudent,
    int? userId,
  }) {
    if (userId != null) {
      user = UserModel(id: userId);
      newUser = false;
    } else {
      user = UserModel();
      newUser = true;
    }
    getClass();
  }

  late UserModel user;
  late final bool newUser;
  final bool isStudent;
  final form = GlobalKey<FormState>();
  bool hasDate = false;

  @observable
  ObservableList<ClassModel> classes = ObservableList();

  @observable
  FileModel? image;

  Future<bool> get getSchool async {
    if (hasDate) return true;

    final temp = await _serviceUser.getUser(user.id!);
    if (temp == null) return false;
    user = temp;

    return hasDate = true;
  }

  String? verifyPassword(String? confirmPassword) {
    if (user.password != confirmPassword) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  Future<void> save() {
    if (newUser) {
      return register();
    } else {
      return update();
    }
  }

  Future<void> register() async {
    try {
      if (form.currentState!.validate()) {
        if (isStudent) {
          user.role = AuthRoleEnum.student;
        } else {
          user.role = AuthRoleEnum.teacher;
        }

        final info = await _service.registerUser(user, image);

        await ModalAlert.show(
          'Cadastro',
          info?['message'] ?? "Aluno registrado com sucesso!",
        );
        Modular.to.navigate(SchoolModule.initialRoute);
      }
    } on CustomException catch (e) {
      ModalAlert.show(
        'Cadastro',
        e.message,
      );
    } catch (e) {
      debugPrint(e.toString());
      ModalAlert.show(
        'Cadastro',
        "Falha ao registrar aluno!",
      );
    }
  }

  Future<void> update() async {}

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

  Future<void> getClass() async {
    try {
      classes = (await _serviceSchool.allClass()).asObservable();
    } catch (_) {}
  }
}
