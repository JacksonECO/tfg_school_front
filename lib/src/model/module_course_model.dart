import 'dart:convert';

class ModuleCourseModel {
  int id;
  String title;
  String description;
  int subjectId;
  int ordenation;
  DateTime createdAt;
  DateTime updatedAt;

  ModuleCourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectId,
    required this.ordenation,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'subjectId': subjectId,
      'ordenation': ordenation,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ModuleCourseModel.fromMap(Map<String, dynamic> map) {
    var createdAtDb = DateTime.tryParse(map['created_at'] as String? ?? '');
    var updatedAtDb = DateTime.tryParse(map['updated_at'] as String? ?? '');
    return ModuleCourseModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      subjectId: map['subject_id'] as int,
      ordenation: map['ordenation'] as int,
      createdAt: createdAtDb!.add(DateTime.now().timeZoneOffset),
      updatedAt: updatedAtDb!.add(DateTime.now().timeZoneOffset),
    );
  }

  String toJson() => json.encode(toMap());

  factory ModuleCourseModel.fromJson(String source) =>
      ModuleCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
