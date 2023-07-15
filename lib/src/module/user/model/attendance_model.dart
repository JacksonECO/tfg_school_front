import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tfg_front/src/module/user/model/user_attendance_model.dart';

import 'package:mobx/mobx.dart';
part 'attendance_model.g.dart';

class AttendanceModel extends _AttendanceModelBase with _$AttendanceModel {
  AttendanceModel({
    super.id,
    super.schoolId,
    super.subjectId,
    super.date,
    super.totalLesson,
    super.users,
    super.createdAt,
    super.updatedAt,
  });

  factory AttendanceModel.empty({int? subjectId}) {
    return AttendanceModel(
      date: DateTime.now(),
      totalLesson: 1,
      subjectId: subjectId,
    );
  }

  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      subjectId: map['subjectId'] != null ? map['subjectId'] as int : null,
      date: map['date'] != null ? DateTime.parse(map['date'] as String) : null,
      totalLesson: map['totalLesson'] != null ? map['totalLesson'] as int : null,
      users: map['students'] != null
          ? List<UserAttendanceModel>.from(
              (map['students'] as List).map<UserAttendanceModel?>(
                (x) => UserAttendanceModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'] as String) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt'] as String) : null,
    );
  }

  factory AttendanceModel.fromJson(String source) =>
      AttendanceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class _AttendanceModelBase with Store {
  int? id;
  int? schoolId;
  int? subjectId;
  @observable
  DateTime? date = DateTime.now();
  @observable
  int? totalLesson;
  @observable
  List<UserAttendanceModel> users;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? get dateString {
    if (date == null) return null;
    return '${date?.day.toString().padLeft(2, '0')}/${date?.month.toString().padLeft(2, '0')}/${date?.year.toString().padLeft(4, '0')}';
  }

  set dateString(String? value) {
    try {
      final temp = value!.split('/');
      date = DateTime(
        int.parse(temp[2]),
        int.parse(temp[1]),
        int.parse(temp[0]),
      );
    } catch (_) {
      date = null;
    }
  }

  int get totalPresent => users.where((element) => element.isPresent).length;
  int get totalAbsent => users.where((element) => !element.isPresent).length;

  _AttendanceModelBase({
    this.id,
    this.schoolId,
    this.subjectId,
    this.date,
    this.totalLesson,
    this.users = const [],
    this.createdAt,
    this.updatedAt,
  });

  AttendanceModel copyWith({
    int? id,
    int? schoolId,
    int? subjectId,
    DateTime? date,
    int? totalLesson,
    List<UserAttendanceModel>? users,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      subjectId: subjectId ?? this.subjectId,
      date: date ?? this.date,
      totalLesson: totalLesson ?? this.totalLesson,
      users: users ?? List.from(this.users.map((x) => x.copyWith())),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolId': schoolId,
      'subjectId': subjectId,
      'date': date?.millisecondsSinceEpoch,
      'totalLesson': totalLesson,
      'students': users.map((x) => x.toMap()).toList(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'AttendanceModel(id: $id, schoolId: $schoolId, subjectId: $subjectId, date: $date, totalLesson: $totalLesson, users: $users, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant AttendanceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.schoolId == schoolId &&
        other.subjectId == subjectId &&
        other.date == date &&
        other.totalLesson == totalLesson &&
        listEquals(other.users, users) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        schoolId.hashCode ^
        subjectId.hashCode ^
        date.hashCode ^
        totalLesson.hashCode ^
        users.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
