import 'dart:convert';

import 'package:tfg_front/src/model/question_model.dart';

class QuizResourceModel {
  String type;
  String title;
  int moduleId;
  List<QuestionModel> questions;
  
  QuizResourceModel({
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

  factory QuizResourceModel.fromMap(Map<String, dynamic> map) {
    return QuizResourceModel(
      type: map['type'] as String,
      title: map['title'] as String,
      moduleId: map['moduleId'] as int,
      questions: List<QuestionModel>.from((map['questions'] as List<int>).map<QuestionModel>((x) => QuestionModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizResourceModel.fromJson(String source) => QuizResourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
