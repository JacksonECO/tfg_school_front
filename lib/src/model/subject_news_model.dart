import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/model/news_model.dart';

class SubjectNewsModel extends SubjectModel {
  final List<NewsModel>? news;
  SubjectNewsModel({
    this.news,
    super.classId,
    super.id,
    super.createdAt,
    super.name,
    super.schoolId,
    super.teacherId,
    super.updatedAt,
  });
  factory SubjectNewsModel.news({
    required List<NewsModel>? news,
    required SubjectModel subject,
  }) {
    return SubjectNewsModel(
      news: news,
      classId: subject.classId,
      id: subject.id,
      createdAt: subject.createdAt,
      name: subject.name, 
      schoolId: subject.schoolId,
      teacherId: subject.teacherId,
      updatedAt: subject.updatedAt,
    );
  }
}