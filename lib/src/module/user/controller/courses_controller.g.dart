// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoursesController on CoursesControllerBase, Store {
  late final _$_allSubjectsAtom =
      Atom(name: 'CoursesControllerBase._allSubjects', context: context);

  List<SubjectModel> get allSubjects {
    _$_allSubjectsAtom.reportRead();
    return super._allSubjects;
  }

  @override
  List<SubjectModel> get _allSubjects => allSubjects;

  @override
  set _allSubjects(List<SubjectModel> value) {
    _$_allSubjectsAtom.reportWrite(value, super._allSubjects, () {
      super._allSubjects = value;
    });
  }

  late final _$_filteredSubjectsAtom =
      Atom(name: 'CoursesControllerBase._filteredSubjects', context: context);

  List<SubjectModel> get filteredSubjects {
    _$_filteredSubjectsAtom.reportRead();
    return super._filteredSubjects;
  }

  @override
  List<SubjectModel> get _filteredSubjects => filteredSubjects;

  @override
  set _filteredSubjects(List<SubjectModel> value) {
    _$_filteredSubjectsAtom.reportWrite(value, super._filteredSubjects, () {
      super._filteredSubjects = value;
    });
  }

  late final _$_statusAtom =
      Atom(name: 'CoursesControllerBase._status', context: context);

  CoursesStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  CoursesStateStatus get _status => status;

  @override
  set _status(CoursesStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_messageErrorAtom =
      Atom(name: 'CoursesControllerBase._messageError', context: context);

  String? get messageError {
    _$_messageErrorAtom.reportRead();
    return super._messageError;
  }

  @override
  String? get _messageError => messageError;

  @override
  set _messageError(String? value) {
    _$_messageErrorAtom.reportWrite(value, super._messageError, () {
      super._messageError = value;
    });
  }

  late final _$_totalSeachItensAtom =
      Atom(name: 'CoursesControllerBase._totalSeachItens', context: context);

  int get totalSeachItens {
    _$_totalSeachItensAtom.reportRead();
    return super._totalSeachItens;
  }

  @override
  int get _totalSeachItens => totalSeachItens;

  @override
  set _totalSeachItens(int value) {
    _$_totalSeachItensAtom.reportWrite(value, super._totalSeachItens, () {
      super._totalSeachItens = value;
    });
  }

  late final _$_filterClassOptionsAtom =
      Atom(name: 'CoursesControllerBase._filterClassOptions', context: context);

  List<String> get filterClassOptions {
    _$_filterClassOptionsAtom.reportRead();
    return super._filterClassOptions;
  }

  @override
  List<String> get _filterClassOptions => filterClassOptions;

  @override
  set _filterClassOptions(List<String> value) {
    _$_filterClassOptionsAtom.reportWrite(value, super._filterClassOptions, () {
      super._filterClassOptions = value;
    });
  }

  late final _$_filterTeacherOptionsAtom = Atom(
      name: 'CoursesControllerBase._filterTeacherOptions', context: context);

  List<String> get filterTeacherOptions {
    _$_filterTeacherOptionsAtom.reportRead();
    return super._filterTeacherOptions;
  }

  @override
  List<String> get _filterTeacherOptions => filterTeacherOptions;

  @override
  set _filterTeacherOptions(List<String> value) {
    _$_filterTeacherOptionsAtom.reportWrite(value, super._filterTeacherOptions,
        () {
      super._filterTeacherOptions = value;
    });
  }

  late final _$loadSubjectsAsyncAction =
      AsyncAction('CoursesControllerBase.loadSubjects', context: context);

  @override
  Future<void> loadSubjects() {
    return _$loadSubjectsAsyncAction.run(() => super.loadSubjects());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
