import 'dart:convert';

import 'package:tfg_front/src/model/answer_model.dart';

class QuestionModel {
  String question;
  double grade;
  List<AnswerModel>? answers;

  QuestionModel({
    required this.question,
    required this.grade,
    this.answers,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'grade': grade,
      if(answers != null) 'answers': answers!.map((x) => x.toMap()).toList()
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      question: map['question'] as String,
      grade: map['grade'] as double,
      answers: List<AnswerModel>.from(
        (map['answers'] as List<int>).map<AnswerModel>(
          (x) => AnswerModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
