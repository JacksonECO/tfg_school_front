import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/service/subject_service.dart';
part 'courses_controller.g.dart';

enum CoursesStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class CoursesController = CoursesControllerBase with _$CoursesController;

abstract class CoursesControllerBase with Store {
  @readonly
  List<SubjectModel> _allSubjects = [];

  @readonly
  List<SubjectModel> _filteredSubjects = [];

  @readonly
  var _status = CoursesStateStatus.initial;

  @readonly
  String? _messageError;

  @readonly
  int _totalSeachItens = 0;

  final _subjectService = Modular.get<SubjectService>();
  final _auth = Modular.get<AuthModel>();

  String filterSubjectName = '';
  String? filterClassName;
  String? filterTeacherName;
  String? filterOrderDate;

  @readonly
  List<String> _filterClassOptions = [];
  @readonly
  List<String> _filterTeacherOptions = [];

  @action
  Future<void> loadSubjects() async {
    try {
      _status = CoursesStateStatus.loading;
      if (_allSubjects.isEmpty) {
        _allSubjects = await _subjectService.allSubjects(_auth.classId!);
      }
      _filteredSubjects = _allSubjects;
      if (_filteredSubjects.isNotEmpty) {
        var seenClassOptions = <String>{};
        _filterClassOptions = _filteredSubjects
            .where((subject) => seenClassOptions.add(subject.className!))
            .map((e) => e.className!)
            .toList();

        var seenTeacherOptions = <String>{};
        _filterTeacherOptions = _filteredSubjects
            .where((subject) => seenTeacherOptions.add(subject.teacherName!))
            .map((e) => e.teacherName!)
            .toList();
      }

      _status = CoursesStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao buscar cursos', error: e, stackTrace: s);
      _status = CoursesStateStatus.error;
      _messageError = 'Erro ao carregar cursos';
    }
  }

  void filterSubjects() {
    try {
      _status = CoursesStateStatus.loading;
      _filteredSubjects = _allSubjects
          .where((subject) => filterSubjectName != ''
              ? subject.name!.toLowerCase().contains(filterSubjectName)
              : true)
          .where((subject) => filterTeacherName != null
              ? subject.teacherName! == filterTeacherName
              : true)
          .where((subject) => filterClassName != null
              ? subject.className! == filterClassName
              : true)
          .toList();
      filterOrderDate == 'Mais Antigos' ?
          _filteredSubjects.sort(((a, b) {
            return a.updatedAt!.compareTo(b.updatedAt!);
          })) : _filteredSubjects.sort(((a, b) {
            return b.updatedAt!.compareTo(a.updatedAt!);
          })) ;
      _totalSeachItens = _filteredSubjects.length;
      _status = CoursesStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao filtrar cursos', error: e, stackTrace: s);
      _status = CoursesStateStatus.error;
      _messageError = 'Erro ao filtrar cursos';
    }
  }

  bool isSomeFilterEnabled() {
    return filterSubjectName != '' ||
        filterClassName != null ||
        filterTeacherName != null ||
        filterOrderDate != null;
  }

  bool isStudent() {
    if (_auth.role == AuthRoleEnum.student) return true;
    return false;
  }
}
