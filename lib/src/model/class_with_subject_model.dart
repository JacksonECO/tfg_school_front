import 'package:tfg_front/src/model/class_model.dart';
import 'package:tfg_front/src/model/subject_model.dart';

class ClassWithSubjectModel extends ClassModel {
  List<SubjectModel> subjects;

  ClassWithSubjectModel({
    this.subjects = const [],
    super.id,
    super.name,
    super.schoolId,
    super.createdAt,
    super.updatedAt,
  });

  factory ClassWithSubjectModel.empty() => ClassWithSubjectModel(
        subjects: [SubjectModel.empty()],
      );

  factory ClassWithSubjectModel.fromModel(ClassModel model, {List<SubjectModel>? subjects}) {
    return ClassWithSubjectModel(
      id: model.id,
      name: model.name,
      schoolId: model.schoolId,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      subjects: subjects ?? [],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'subjects': subjects.map((x) => x.toMap()).toList(),
    };
  }

  factory ClassWithSubjectModel.fromMap(Map<String, dynamic> map) {
    return ClassWithSubjectModel.fromModel(
      ClassModel.fromMap(map),
      subjects: map['subjects'] != null
          ? (map['subjects'] as List)
              .map((x) => SubjectModel.fromMap(x as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  @override
  ClassWithSubjectModel copyWith({
    int? id,
    int? schoolId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SubjectModel>? subjects,
  }) {
    return ClassWithSubjectModel(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      subjects: subjects ?? this.subjects,
    );
  }
}
