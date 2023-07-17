import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/module_course_model.dart';
import 'package:tfg_front/src/module/user/service/module_course_service.dart';

class ModuleCouseController {
  final _service = Modular.get<ModuleCourseService>();
  final bool isProf = Modular.get<AuthModel>().role == AuthRoleEnum.teacher;
  bool _hasData = false;

  SubjectModel? subject;
  bool isNew = true;
  ObservableList<ModuleCourseModel> _modules = ObservableList<ModuleCourseModel>();
  List<ModuleCourseModel> get modules => _modules;
  set modules(List<ModuleCourseModel> value) {
    _modules = value.asObservable();
  }

  int get subjectId => subject?.id ?? 0;

  Future<bool> get future async {
    if (_hasData) return true;

    modules = await _service.allModule(subjectId);
    modules.sort((a, b) => a.order.compareTo(b.order));

    return _hasData = true;
  }

  Future<void> moduleToDown(int order) async {
    try {
      if (order == modules.length - 1) return;

      modules[order].order++;
      modules[order + 1].order--;
      modules.sort((a, b) => a.order.compareTo(b.order));

      await EasyLoading.show();
      await _update(order);
      await _update(order + 1);
      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao mudar ordem!",
      );
    }
  }

  Future<void> moduleToUp(int order) async {
    try {
      if (order == 0) return;
      await EasyLoading.show();

      modules[order].order--;
      modules[order - 1].order++;

      await _update(order);
      await _update(order - 1);

      modules.sort((a, b) => a.order.compareTo(b.order));

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao mudar ordem!",
      );
    }
  }

  Future<void> edit(int order, ModuleCourseModel module) async {
    try {
      await EasyLoading.show();

      modules[order] = module;
      await _update(order);

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao editar modulo!",
      );
    }
  }

  Future<void> delete(int order) async {
    try {
      await EasyLoading.show();

      await _service.delete(modules[order].id!);
      modules.removeAt(order);

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao editar modulo!",
      );
    }
  }

  Future<void> addModule(ModuleCourseModel module) async {
    try {
      await EasyLoading.show();

      final id = await _service.create(module);
      if (id != null) {
        modules.add(module.copyWith(id: id));
      } else {
        modules = await _service.allModule(subjectId);
        modules.sort((a, b) => a.order.compareTo(b.order));
      }

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao adicionar modulo!",
      );
    }
  }

  Future<void> addItem(int orderModel, ItemModuleCourseModel item) async {
    try {
      await EasyLoading.show();

      modules[orderModel].content.add(item);
      await _update(orderModel);

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao adicionar recurso!",
      );
    }
  }

  Future<void> editItem(int orderModel, ItemModuleCourseModel old, ItemModuleCourseModel item) async {
    try {
      await EasyLoading.show();

      final index = modules[orderModel].content.indexWhere((element) => element == old);
      modules[orderModel].content[index] = item;
      await _update(orderModel);

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao editar recurso!",
      );
    }
  }

  Future<void> removeItem(int orderModule, ItemModuleCourseModel item) async {
    try {
      await EasyLoading.show();

      modules[orderModule].content.remove(item);
      await _update(orderModule);

      await EasyLoading.dismiss();
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao remover recurso!",
      );
    }
  }

  Future<void> _update(int index) async {
    await _service.update(modules[index]);
  }

  Future<void> sendResponse(int orderModule, ItemModuleCourseModel item, ItemModuleCourseModel response) async {
    try {
      await EasyLoading.show();

      final index = modules[orderModule].content.indexWhere((element) => element == item);

      final question = modules[orderModule].content[index];
      if (question.uuid == null) throw Exception('Atividade não possui uuid');

      final message = await _service.sendResponse(
        item: question,
        response: response,
        subjectId: subjectId,
        studentId: Modular.get<AuthModel>().userId!,
      );

      await EasyLoading.dismiss();
      ModalAlert.show('Entregue', message);
    } catch (e) {
      await EasyLoading.dismiss();
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao realizar entrega!",
      );
    }
  }
}
