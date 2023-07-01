import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/module/user/model/attendance_model.dart';
import 'package:tfg_front/src/module/user/model/user_attendance_model.dart';
import 'package:tfg_front/src/service/attendance_service.dart';

class AttendanceController {
  final _service = Modular.get<AttendanceService>();

  AttendanceController({
    required this.subjectId,
    required this.classId,
    int? attendanceId,
    AttendanceModel? attendanceModel,
  }) {
    if (attendanceModel != null) {
      this.attendanceModel = attendanceModel;
      newAttendance = false;
    } else if (attendanceId != null) {
      this.attendanceModel = AttendanceModel(id: attendanceId);
      newAttendance = false;
    } else {
      this.attendanceModel = AttendanceModel.empty(subjectId: subjectId);
      newAttendance = true;
    }
  }

  AttendanceModel attendanceModel = AttendanceModel.empty();

  late final bool newAttendance;
  late final int subjectId;
  late final int classId;
  final form = GlobalKey<FormState>();
  bool _hasDate = false;

  Future<bool> get future async {
    if (_hasDate) return true;

    if (newAttendance) {
      attendanceModel.users = await _getAttendanceUsers();
    } else if (attendanceModel.users.isEmpty) {
      attendanceModel = await _service.getAttendance(attendanceModel.id!);
    }

    return _hasDate = true;
  }

  Future<List<UserAttendanceModel>> _getAttendanceUsers() async {
    try {
      final list = await _service.getAttendanceUsers(classId);
      if (list.isEmpty) {
        Modular.to.pop();
        ModalAlert.show(
          'Erro',
          "Não há alunos cadastrados na matéria!",
        );
      }

      return list;
    } on CustomException catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        e.message,
      );
      return [];
    } catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao buscar alunos!",
      );
      return [];
    }
  }

  Future<void> save() {
    if (newAttendance) {
      return _register();
    } else {
      return _update();
    }
  }

  Future<void> _register() async {
    try {
      if (form.currentState!.validate()) {
        await _service.register(attendanceModel);
        await ModalAlert.show(
          'Sucesso',
          "Presença registrada com sucesso!",
        );
        Modular.to.pop(true);
      }
    } on CustomException catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        e.message,
      );
    } catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao registrar presença!",
      );
    }
  }

  Future<void> _update() async {
    try {
      if (form.currentState!.validate()) {
        await _service.update(attendanceModel);
        await ModalAlert.show(
          'Sucesso',
          "Presença atualizada com sucesso!",
        );
        Modular.to.pop(true);
      }
    } on CustomException catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        e.message,
      );
    } catch (e) {
      log(e.toString());
      ModalAlert.show(
        'Erro',
        "Falha ao atualizar presença!",
      );
    }
  }

  bool get allPresent => attendanceModel.users.every((element) => element.isPresent);
  bool get allAbsent => !attendanceModel.users.every((element) => !element.isPresent);

  void setAllPresent() {
    for (var element in attendanceModel.users) {
      element.isPresent = true;
    }
  }

  void setAllAbsent() {
    for (var element in attendanceModel.users) {
      element.isPresent = false;
    }
  }
}
