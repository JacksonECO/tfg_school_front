import 'dart:convert';

class AnswerModel {
  String? answer;
  bool? isCorret;
  
  AnswerModel({
    this.answer,
    this.isCorret,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'answer': answer,
      'isCorret': isCorret,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      answer: map['answer'] != null ? map['answer'] as String : null,
      isCorret: map['isCorret'] != null ? map['isCorret'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
