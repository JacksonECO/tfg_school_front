// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileUserController on _ProfileUserControllerBase, Store {
  late final _$classesAtom =
      Atom(name: '_ProfileUserControllerBase.classes', context: context);

  @override
  ObservableList<ClassModel> get classes {
    _$classesAtom.reportRead();
    return super.classes;
  }

  @override
  set classes(ObservableList<ClassModel> value) {
    _$classesAtom.reportWrite(value, super.classes, () {
      super.classes = value;
    });
  }

  late final _$imageAtom =
      Atom(name: '_ProfileUserControllerBase.image', context: context);

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
classes: ${classes},
image: ${image}
    ''';
  }
}
