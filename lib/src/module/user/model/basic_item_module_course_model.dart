import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_enum.dart';
import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
part 'basic_item_module_course_model.g.dart';

class BasicItemModuleCourseModel extends _BasicModuleCouseModelBase with _$BasicItemModuleCourseModel {
  BasicItemModuleCourseModel({
    required super.type,
    super.title = '',
    super.content = '',
  });

  factory BasicItemModuleCourseModel.fromMap(Map<String, dynamic> map) {
    return BasicItemModuleCourseModel(
      type: ItemModuleCourseEnum.fromString(map['type'] as String?)!,
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
    );
  }

  factory BasicItemModuleCourseModel.fromJson(String source) =>
      BasicItemModuleCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class _BasicModuleCouseModelBase extends ItemModuleCourseModel with Store {
  _BasicModuleCouseModelBase({
    required super.type,
    super.title = '',
    this.content = '',
  });

  @observable
  String content;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ...super.toMap(),
      'content': content,
    };
  }
}
