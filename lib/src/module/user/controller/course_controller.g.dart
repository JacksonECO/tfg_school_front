// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CourseController on CourseControllerBase, Store {
  late final _$_statusAtom =
      Atom(name: 'CourseControllerBase._status', context: context);

  CourseStateStatus get status {
    _$_statusAtom.reportRead();
    return super._status;
  }

  @override
  CourseStateStatus get _status => status;

  @override
  set _status(CourseStateStatus value) {
    _$_statusAtom.reportWrite(value, super._status, () {
      super._status = value;
    });
  }

  late final _$_messageErrorAtom =
      Atom(name: 'CourseControllerBase._messageError', context: context);

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

  late final _$_subjectAtom =
      Atom(name: 'CourseControllerBase._subject', context: context);

  SubjectModel? get subject {
    _$_subjectAtom.reportRead();
    return super._subject;
  }

  @override
  SubjectModel? get _subject => subject;

  @override
  set _subject(SubjectModel? value) {
    _$_subjectAtom.reportWrite(value, super._subject, () {
      super._subject = value;
    });
  }

  late final _$_modulesCourseAtom =
      Atom(name: 'CourseControllerBase._modulesCourse', context: context);

  List<ModuleCourseModel> get modulesCourse {
    _$_modulesCourseAtom.reportRead();
    return super._modulesCourse;
  }

  @override
  List<ModuleCourseModel> get _modulesCourse => modulesCourse;

  @override
  set _modulesCourse(List<ModuleCourseModel> value) {
    _$_modulesCourseAtom.reportWrite(value, super._modulesCourse, () {
      super._modulesCourse = value;
    });
  }

  late final _$_resourcesAtom =
      Atom(name: 'CourseControllerBase._resources', context: context);

  List<dynamic> get resources {
    _$_resourcesAtom.reportRead();
    return super._resources;
  }

  @override
  List<dynamic> get _resources => resources;

  @override
  set _resources(List<dynamic> value) {
    _$_resourcesAtom.reportWrite(value, super._resources, () {
      super._resources = value;
    });
  }

  late final _$loadSubjectAsyncAction =
      AsyncAction('CourseControllerBase.loadSubject', context: context);

  @override
  Future<void> loadSubject(int subjectId) {
    return _$loadSubjectAsyncAction.run(() => super.loadSubject(subjectId));
  }

  late final _$loadModulesAsyncAction =
      AsyncAction('CourseControllerBase.loadModules', context: context);

  @override
  Future<void> loadModules(int subjectId) {
    return _$loadModulesAsyncAction.run(() => super.loadModules(subjectId));
  }

  late final _$createModuleAsyncAction =
      AsyncAction('CourseControllerBase.createModule', context: context);

  @override
  Future<void> createModule(String title, String description, int subjectId) {
    return _$createModuleAsyncAction
        .run(() => super.createModule(title, description, subjectId));
  }

  late final _$deleteModuleAsyncAction =
      AsyncAction('CourseControllerBase.deleteModule', context: context);

  @override
  Future<void> deleteModule(int moduleId, int subjectId) {
    return _$deleteModuleAsyncAction
        .run(() => super.deleteModule(moduleId, subjectId));
  }

  late final _$updateModuleAsyncAction =
      AsyncAction('CourseControllerBase.updateModule', context: context);

  @override
  Future<void> updateModule(
      {required int moduleId,
      String? title,
      String? descripton,
      String? content,
      int? ordenation,
      bool update = true,
      required int subjectId}) {
    return _$updateModuleAsyncAction.run(() => super.updateModule(
        moduleId: moduleId,
        title: title,
        descripton: descripton,
        content: content,
        ordenation: ordenation,
        update: update,
        subjectId: subjectId));
  }

  late final _$handleUpModuleAsyncAction =
      AsyncAction('CourseControllerBase.handleUpModule', context: context);

  @override
  Future<void> handleUpModule(int moduleId, int subjectId, int ordenation) {
    return _$handleUpModuleAsyncAction
        .run(() => super.handleUpModule(moduleId, subjectId, ordenation));
  }

  late final _$handleDownModuleAsyncAction =
      AsyncAction('CourseControllerBase.handleDownModule', context: context);

  @override
  Future<void> handleDownModule(int moduleId, int subjectId, int ordenation) {
    return _$handleDownModuleAsyncAction
        .run(() => super.handleDownModule(moduleId, subjectId, ordenation));
  }

  late final _$addResourceTextAsyncAction =
      AsyncAction('CourseControllerBase.addResourceText', context: context);

  @override
  Future<void> addResourceText(String title, String content, int moduleId) {
    return _$addResourceTextAsyncAction
        .run(() => super.addResourceText(title, content, moduleId));
  }

  late final _$addResourceLinkAsyncAction =
      AsyncAction('CourseControllerBase.addResourceLink', context: context);

  @override
  Future<void> addResourceLink(String title, String link, int moduleId) {
    return _$addResourceLinkAsyncAction
        .run(() => super.addResourceLink(title, link, moduleId));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
