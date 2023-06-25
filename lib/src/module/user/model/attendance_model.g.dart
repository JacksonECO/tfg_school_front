// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AttendanceModel on _AttendanceModelBase, Store {
  late final _$dateAtom =
      Atom(name: '_AttendanceModelBase.date', context: context);

  @override
  DateTime? get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime? value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$totalLessonAtom =
      Atom(name: '_AttendanceModelBase.totalLesson', context: context);

  @override
  int? get totalLesson {
    _$totalLessonAtom.reportRead();
    return super.totalLesson;
  }

  @override
  set totalLesson(int? value) {
    _$totalLessonAtom.reportWrite(value, super.totalLesson, () {
      super.totalLesson = value;
    });
  }

  late final _$usersAtom =
      Atom(name: '_AttendanceModelBase.users', context: context);

  @override
  List<UserAttendanceModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserAttendanceModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  @override
  String toString() {
    return '''
date: ${date},
totalLesson: ${totalLesson},
users: ${users}
    ''';
  }
}
