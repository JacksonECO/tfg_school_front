// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_class_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListClassController on _ListClassControllerBase, Store {
  late final _$_paginationAtom =
      Atom(name: '_ListClassControllerBase._pagination', context: context);

  PaginationData<ClassModel> get pagination {
    _$_paginationAtom.reportRead();
    return super._pagination;
  }

  @override
  PaginationData<ClassModel> get _pagination => pagination;

  @override
  set _pagination(PaginationData<ClassModel> value) {
    _$_paginationAtom.reportWrite(value, super._pagination, () {
      super._pagination = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
