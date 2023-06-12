import 'dart:convert';

import 'package:tfg_front/src/model/question_model.dart';

class FillTheBlanksResourceModel {
  String type;
  String title;
  int moduleId;
  List<QuestionModel> questions;

  FillTheBlanksResourceModel({
    required this.type,
    required this.title,
    required this.moduleId,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
      'moduleId': moduleId,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory FillTheBlanksResourceModel.fromMap(Map<String, dynamic> map) {
    return FillTheBlanksResourceModel(
      type: map['type'] as String,
      title: map['title'] as String,
      moduleId: map['moduleId'] as int,
      questions: List<QuestionModel>.from((map['questions'] as List<int>).map<QuestionModel>((x) => QuestionModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FillTheBlanksResourceModel.fromJson(String source) =>
      FillTheBlanksResourceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
