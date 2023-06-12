import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/modal_alert.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/class_with_subject_model.dart';
import 'package:tfg_front/src/model/date_custom.dart';
import 'package:tfg_front/src/model/file_model.dart';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/model/week_day_enum.dart';
import 'package:tfg_front/src/service/class_service.dart';
import 'package:tfg_front/src/service/user_service.dart';
part 'class_controller.g.dart';

class ClassController = _ClassControllerBase with _$ClassController;

abstract class _ClassControllerBase with Store {
  final _service = Modular.get<ClassService>();
  final _serviceUser = Modular.get<UserService>();

  _ClassControllerBase({
    int? userId,
    ClassWithSubjectModel? userClass,
  }) {
    if (userClass != null) {
      classModel = userClass;
      newClass = false;
    } else if (userId != null) {
      classModel = ClassWithSubjectModel(id: userId);
      newClass = false;
    } else {
      classModel = ClassWithSubjectModel.empty();
      newClass = true;
    }
    requestListTeachers();
  }

  @observable
  ClassWithSubjectModel _classModel = ClassWithSubjectModel.empty();
  @computed
  ClassWithSubjectModel get classModel => _classModel.copyWith(
        subjects: _subjects,
      );
  set classModel(ClassWithSubjectModel value) {
    _classModel = value;
    _subjects = ObservableList.of(value.subjects);
  }

  @observable
  ObservableList<SubjectModel> _subjects = ObservableList<SubjectModel>();

  @observable
  List<UserModel> teachers = [];

  late final bool newClass;
  final form = GlobalKey<FormState>();
  bool _hasDate = false;

  @observable
  ObservableList<ClassWithSubjectModel> classes = ObservableList();

  @observable
  FileModel? image;

  Future<bool> get future async {
    if (_hasDate || newClass) return true;

    if (classModel.name == null) {
      classModel = await _service.getClassWithSubject(classModel.id!);
    }

    // Adiciona os dias vazios
    for (var element in List.generate(classModel.subjects.length, (index) => index)) {
      addPeriod(element);
    }

    return _hasDate = true;
  }

  void addSubject() {
    classModel.subjects.add(SubjectModel.empty());
  }

  void removePeriod(int subject, int period) {
    if ((classModel.subjects[subject].times?.length ?? 0) <= 1) return;

    // Se tiver apenas um dia como vazio, não pode remover
    if (classModel.subjects[subject].times![period].isEmpty &&
        classModel.subjects[subject].times!.where((element) => element.isEmpty).toList().length <=
            1) return;

    classModel.subjects[subject].times?.removeAt(period);
  }

  void addPeriod(int subject) {
    if (classModel.subjects[subject].times
            ?.any((element) => element.weekDay == WeekDayEnum.empty) ??
        false) return;

    if (classModel.subjects[subject].times == null) {
      classModel.subjects[subject].times = [];
    }

    classModel.subjects[subject].times!.add(DateCustom(weekDay: WeekDayEnum.empty));
  }

  Future<void> requestListTeachers() async {
    try {
      teachers = await _serviceUser.getUsers(AuthRoleEnum.teacher);
    } catch (e) {
      log(e.toString());
    }
  }

  UserModel? getTeacher(int indexSubject) {
    var temp = teachers.firstWhere(
      (element) => element.id == classModel.subjects[indexSubject].teacherId,
      orElse: () => UserModel(),
    );

    if (temp.id == null) return null;
    return temp;
  }

  void setTeacher(int indexSubject, UserModel? teacher) {
    if (teacher == null) return;
    classModel.subjects[indexSubject].teacherId = teacher.id;
    classModel.subjects[indexSubject].teacherName = teacher.name;
  }

  Future<void> save() {
    if (newClass) {
      return register();
    } else {
      return update();
    }
  }

  Future<void> register() async {
    try {
      if (form.currentState!.validate()) {
        await _service.register(classModel);
        await ModalAlert.show(
          'Sucesso',
          "Turma registrado com sucesso!",
        );
        Modular.to.pop();
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
        "Falha ao registrar turma!",
      );
    }
  }

  Future<void> update() async {
    try {
      if (form.currentState!.validate()) {
        await _service.update(classModel);
        await ModalAlert.show(
          'Sucesso',
          "Turma atualizada com sucesso!",
        );
        Modular.to.pop();
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
        "Falha ao atualizar turma!",
      );
    }
  }
}
