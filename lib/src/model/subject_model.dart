import 'dart:convert';

class SubjectModel {
  int? id;
  int? schoolId;
  int? classId;
  int? teacherId;
  String? name;
  String? className;
  String? teacherName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? picture;
  
  SubjectModel({
    this.id,
    this.schoolId,
    this.classId,
    this.teacherId,
    this.name,
    this.className,
    this.teacherName,
    this.createdAt,
    this.updatedAt,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'schoolId': schoolId,
      'classId': classId,
      'teacherId': teacherId,
      'name': name,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'className': className,
      'teacherName': teacherName,
      'picture': picture,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['id'] != null ? map['id'] as int : null,
      schoolId: map['schoolId'] != null ? map['schoolId'] as int : null,
      classId: map['classId'] != null ? map['classId'] as int : null,
      teacherId: map['teacherId'] != null ? map['teacherId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      className: map['className'] != null ? map['className'] as String : null,
      teacherName: map['teacherName'] != null ? map['teacherName'] as String : null,
      picture: map['picture'] != null ? map['picture'] as String : null,
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) => SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
