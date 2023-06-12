import 'dart:convert';

import 'package:tfg_front/src/model/question_model.dart';

class DissertResourceModel {
  String type; 
  String title;
  List<QuestionModel> questions;
  int moduleId;
  
  DissertResourceModel({
    required this.type,
    required this.title,
    required this.questions,
    required this.moduleId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'moduleId': moduleId,
    };
  }

  factory DissertResourceModel.fromMap(Map<String, dynamic> map) {
    return DissertResourceModel(
      type: map['type'] as String,
      title: map['title'] as String,
      questions: List<QuestionModel>.from((map['questions'] as List<int>).map<QuestionModel>((x) => QuestionModel.fromMap(x as Map<String,dynamic>),),),
      moduleId: map['moduleId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DissertResourceModel.fromJson(String source) =>
      DissertResourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
