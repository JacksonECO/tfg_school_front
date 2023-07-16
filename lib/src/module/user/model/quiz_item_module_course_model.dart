import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/core/helpers/date_time_extension.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_enum.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:tfg_front/src/module/user/model/quiz_model.dart';
part 'quiz_item_module_course_model.g.dart';

class QuizItemModuleCourseModel extends _QuizModuleCouseModelBase with _$QuizItemModuleCourseModel {
  QuizItemModuleCourseModel({
    required super.type,
    required super.quizzes,
    super.uuid,
    super.title = '',
  });

  factory QuizItemModuleCourseModel.fromMap(Map<String, dynamic> map) {
    return QuizItemModuleCourseModel(
      type: ItemModuleCourseEnum.fromString(map['type'] as String?)!,
      title: map['title'] as String? ?? '',
      uuid: map['uuid'] as int? ?? DateTime.now().random,
      quizzes: List<QuizModel>.from(
        map['quizzes'].map<QuizModel?>(
          (x) => QuizModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory QuizItemModuleCourseModel.fromJson(String source) =>
      QuizItemModuleCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  QuizItemModuleCourseModel copyWith({
    ItemModuleCourseEnum? type,
    List<QuizModel>? quizzes,
    int? uuid,
    String? title,
  }) {
    return QuizItemModuleCourseModel(
      type: type ?? this.type,
      uuid: uuid ?? this.uuid,
      quizzes: (quizzes ?? this.quizzes).map((e) => e.copyWith()).toList(),
      title: title ?? this.title,
    );
  }
}

abstract class _QuizModuleCouseModelBase extends ItemModuleCourseModel with Store {
  _QuizModuleCouseModelBase({
    required super.type,
    int? uuid,
    super.title = '',
    required List<QuizModel> quizzes,
  })  : _quizzes = quizzes.asObservable(),
        super(uuid: uuid ?? DateTime.now().random);

  ObservableList<QuizModel> _quizzes = ObservableList<QuizModel>();
  List<QuizModel> get quizzes => _quizzes;
  set quizzes(List<QuizModel> value) {
    _quizzes = value.asObservable();
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'quizzes': quizzes.map((x) => x.toMap()).toList(),
    };
  }

  void cleanResponses() {
    for (var element in quizzes) {
      element.indexSolution = -1;
    }
  }

  bool get isAnswered {
    for (var element in quizzes) {
      if (element.indexSolution == -1) return false;
    }
    return true;
  }
}
