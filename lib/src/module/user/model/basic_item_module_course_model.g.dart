// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_item_module_course_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BasicItemModuleCourseModel on _BasicModuleCouseModelBase, Store {
  late final _$contentAtom =
      Atom(name: '_BasicModuleCouseModelBase.content', context: context);

  @override
  String get content {
    _$contentAtom.reportRead();
    return super.content;
  }

  @override
  set content(String value) {
    _$contentAtom.reportWrite(value, super.content, () {
      super.content = value;
    });
  }

  @override
  String toString() {
    return '''
content: ${content}
    ''';
  }
}
