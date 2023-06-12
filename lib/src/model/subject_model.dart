import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tfg_front/src/model/date_custom.dart';
import 'package:tfg_front/src/model/week_day_enum.dart';

class SubjectModel {
  int? id;
  int? schoolId;
  int? classId;
  int? teacherId;
  String? teacherName;
  String? className;
  String? name;
  String? color;
  List<DateCustom>? times;
  String? picture;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubjectModel({
    this.id,
    this.schoolId,
    this.classId,
    this.teacherId,
    this.teacherName,
    this.className,
    this.name,
    this.color = '#FFFFFF',
    this.times,
    this.picture,
    this.createdAt,
    this.updatedAt,
  });

  factory SubjectModel.empty() => SubjectModel(
        color: '#FFFFFF',
        times: [DateCustom(weekDay: WeekDayEnum.empty)],
      );

  Color get toColor => Color(int.parse(color?.substring(1, 7) ?? '000000', radix: 16) + 0xFF000000);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolId': schoolId,
      'classId': classId,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'className': className,
      'name': name,
      'color': color,
      'times': times?.map((DateCustom e) => e.toMap()).toList(),
      'picture': picture,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      classId: map['classId'] != null ? map['classId'] as int : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as int : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      times: map['times'] != null
          ? (map['times'] as List<dynamic>)
              .map((dynamic e) => DateCustom.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
