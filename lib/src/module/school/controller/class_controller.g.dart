// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClassController on _ClassControllerBase, Store {
  Computed<ClassWithSubjectModel>? _$classModelComputed;

  @override
  ClassWithSubjectModel get classModel => (_$classModelComputed ??=
          Computed<ClassWithSubjectModel>(() => super.classModel,
              name: '_ClassControllerBase.classModel'))
      .value;

  late final _$_classModelAtom =
      Atom(name: '_ClassControllerBase._classModel', context: context);

  @override
  ClassWithSubjectModel get _classModel {
    _$_classModelAtom.reportRead();
    return super._classModel;
  }

  @override
  set _classModel(ClassWithSubjectModel value) {
    _$_classModelAtom.reportWrite(value, super._classModel, () {
      super._classModel = value;
    });
  }

  late final _$_subjectsAtom =
      Atom(name: '_ClassControllerBase._subjects', context: context);

  @override
  ObservableList<SubjectModel> get _subjects {
    _$_subjectsAtom.reportRead();
    return super._subjects;
  }

  @override
  set _subjects(ObservableList<SubjectModel> value) {
    _$_subjectsAtom.reportWrite(value, super._subjects, () {
      super._subjects = value;
    });
  }

  late final _$teachersAtom =
      Atom(name: '_ClassControllerBase.teachers', context: context);

  @override
  List<UserModel> get teachers {
    _$teachersAtom.reportRead();
    return super.teachers;
  }

  @override
  set teachers(List<UserModel> value) {
    _$teachersAtom.reportWrite(value, super.teachers, () {
      super.teachers = value;
    });
  }

  late final _$classesAtom =
      Atom(name: '_ClassControllerBase.classes', context: context);

  @override
  ObservableList<ClassWithSubjectModel> get classes {
    _$classesAtom.reportRead();
    return super.classes;
  }

  @override
  set classes(ObservableList<ClassWithSubjectModel> value) {
    _$classesAtom.reportWrite(value, super.classes, () {
      super.classes = value;
    });
  }

  late final _$imageAtom =
      Atom(name: '_ClassControllerBase.image', context: context);

  @override
  FileModel? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(FileModel? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  @override
  String toString() {
    return '''
teachers: ${teachers},
classes: ${classes},
image: ${image},
classModel: ${classModel}
    ''';
  }
}
