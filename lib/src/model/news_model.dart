import 'dart:convert';

class NewsModel {
  int? id;
  String title;
  String description;
  int? schoolId;
  int? subjectId;
  int? classId;
  int? totalCount;
  DateTime? createdAt;
  DateTime? updatedAt;

  NewsModel({
    this.id,
    required this.title,
    required this.description,
    this.schoolId,
    this.subjectId,
    this.classId,
    this.totalCount,
    this.createdAt,
    this.updatedAt,
  });

  factory NewsModel.clean() {
    return NewsModel(
      id: null,
      title: '',
      description: '',
      schoolId: null,
      subjectId: null,
      classId: null,
      totalCount: null,
      createdAt: null,
      updatedAt: null,
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'schoolId': schoolId,
      'subjectId': subjectId,
      'classId': classId,
      'totalCount': totalCount,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    var createdAtDb = DateTime.tryParse(map['created_at'] as String? ?? '');
    var updatedAtDb = DateTime.tryParse(map['updated_at'] as String? ?? '');
    return NewsModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      description: map['description'] as String,
      schoolId: map['school_id'] != null ? map['school_id'] as int : null,
      subjectId: map['subject_id'] != null ? map['subject_id'] as int : null,
      classId: map['class_id'] != null ? map['class_id'] as int : null,
      totalCount: map['totalCount'] != null ? map['totalCount'] as int : null,
      createdAt: createdAtDb?.add(DateTime.now().timeZoneOffset),
      updatedAt: updatedAtDb?.add(DateTime.now().timeZoneOffset),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
