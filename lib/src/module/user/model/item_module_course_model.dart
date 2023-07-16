import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/module/user/model/basic_item_module_course_model.dart';

import 'package:tfg_front/src/module/user/model/item_module_course_enum.dart';
import 'package:tfg_front/src/module/user/model/quiz_item_module_course_model.dart';

part 'item_module_course_model.g.dart';

abstract class ItemModuleCourseModel extends _ItemModuleCourseModelBase with _$ItemModuleCourseModel {
  ItemModuleCourseModel({
    required super.type,
    super.uuid,
    super.title = '',
  });

  factory ItemModuleCourseModel.fromMap(Map<String, dynamic> map) {
    final ItemModuleCourseEnum type = ItemModuleCourseEnum.fromString(map['type'] as String?)!;

    switch (type) {
      case ItemModuleCourseEnum.text:
      case ItemModuleCourseEnum.link:
        return BasicItemModuleCourseModel.fromMap(map);

      case ItemModuleCourseEnum.quiz:
        return QuizItemModuleCourseModel.fromMap(map);

      case ItemModuleCourseEnum.file:
      default:
        throw UnimplementedError();
    }
  }

  factory ItemModuleCourseModel.fromJson(String source) =>
      ItemModuleCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class _ItemModuleCourseModelBase with Store {
  _ItemModuleCourseModelBase({
    required this.type,
    this.title = '',
    this.uuid,
  });

  ItemModuleCourseEnum type;
  @observable
  String title;
  int? uuid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.name,
      'uuid': uuid,
      'title': title,
    };
  }

  @override
  String toString() => '_ItemModuleCourseModelBase(type: $type, title: $title)';
}
