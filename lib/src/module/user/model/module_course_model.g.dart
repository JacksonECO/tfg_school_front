// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_course_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ModuleCourseModel on _ModuleCourseModelBase, Store {
  late final _$orderAtom =
      Atom(name: '_ModuleCourseModelBase.order', context: context);

  @override
  int get order {
    _$orderAtom.reportRead();
    return super.order;
  }

  @override
  set order(int value) {
    _$orderAtom.reportWrite(value, super.order, () {
      super.order = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_ModuleCourseModelBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_ModuleCourseModelBase.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  @override
  String toString() {
    return '''
order: ${order},
title: ${title},
description: ${description}
    ''';
  }
}
