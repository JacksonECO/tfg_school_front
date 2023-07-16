import 'dart:convert';
import 'dart:developer';

import 'package:mobx/mobx.dart';

part 'quiz_model.g.dart';

class QuizModel extends _QuizModelBase with _$QuizModel {
  QuizModel({
    required super.question,
    required super.indexSolution,
    super.possibleSolution = const ['', '', '', ''],
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    try {
      return QuizModel(
        question: map['question'] as String,
        possibleSolution: List<String>.from((map['possibleSolution'] as List)),
        indexSolution: map['indexSolution'] as int,
      );
    } catch (e, s) {
      log('QuizModel.fromMap', error: e, stackTrace: s);
      rethrow;
    }
  }

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QuizModel copyWith({
    String? question,
    List<String>? possibleSolution,
    int? indexSolution,
  }) {
    return QuizModel(
      question: question ?? this.question,
      possibleSolution: List.from(possibleSolution ?? this.possibleSolution),
      indexSolution: indexSolution ?? this.indexSolution,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'possibleSolution': possibleSolution,
      'indexSolution': indexSolution,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'QuizModel(question: $question, possibleSolution: $possibleSolution, indexSolution: $indexSolution)';
}

abstract class _QuizModelBase with Store {
  _QuizModelBase({
    required this.question,
    required this.possibleSolution,
    required this.indexSolution,
  });

  String question;
  List<String> possibleSolution;
  @observable
  int indexSolution;
}
