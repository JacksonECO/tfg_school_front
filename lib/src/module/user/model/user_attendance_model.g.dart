// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attendance_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserAttendanceModel on _UserAttendanceModelBase, Store {
  late final _$isPresentAtom =
      Atom(name: '_UserAttendanceModelBase.isPresent', context: context);

  @override
  bool get isPresent {
    _$isPresentAtom.reportRead();
    return super.isPresent;
  }

  @override
  set isPresent(bool value) {
    _$isPresentAtom.reportWrite(value, super.isPresent, () {
      super.isPresent = value;
    });
  }

  @override
  String toString() {
    return '''
isPresent: ${isPresent}
    ''';
  }
}
