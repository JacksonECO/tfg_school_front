import 'dart:convert';
import 'dart:developer';

import 'package:tfg_front/src/module/user/model/item_module_course_model.dart';
import 'package:mobx/mobx.dart';
part 'module_course_model.g.dart';

class ModuleCourseModel extends _ModuleCourseModelBase with _$ModuleCourseModel {
  ModuleCourseModel({
    super.id,
    required super.subjectId,
    required super.order,
    required super.title,
    required super.description,
    required super.content,
    super.createdAt,
    super.updatedAt,
  });

  factory ModuleCourseModel.fromMap(Map<String, dynamic> map) {
    try {
      return ModuleCourseModel(
        id: map['id'] != null ? map['id'] as int : null,
        subjectId: map['subject_id'] as int,
        order: map['ordenation'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        content: map['content'].toString() == '{}'
            ? []
            : List<ItemModuleCourseModel>.from(
                map['content'].map<ItemModuleCourseModel?>(
                  (x) => ItemModuleCourseModel.fromMap(x as Map<String, dynamic>),
                ),
              ),
        createdAt: map['created_at'] != null ? map['created_at'] as String : null,
        updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
      );
    } catch (e, s) {
      log('ModuleCourseModel.fromMap', error: e, stackTrace: s);
      rethrow;
    }
  }

  factory ModuleCourseModel.fromJson(String source) => ModuleCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class _ModuleCourseModelBase with Store {
  int? id;
  int subjectId;
  @observable
  int order;
  @observable
  String title;
  @observable
  String description;
  String? createdAt;
  String? updatedAt;

  ObservableList<ItemModuleCourseModel> _content = ObservableList<ItemModuleCourseModel>();
  List<ItemModuleCourseModel> get content => _content;
  set content(List<ItemModuleCourseModel> value) {
    _content = value.asObservable();
  }

  _ModuleCourseModelBase({
    this.id,
    required this.subjectId,
    required this.order,
    required this.title,
    required this.description,
    required List<ItemModuleCourseModel> content,
    this.createdAt,
    this.updatedAt,
  }) : _content = content.asObservable();

  ModuleCourseModel copyWith({
    int? id,
    int? subjectId,
    int? order,
    String? title,
    String? description,
    List<ItemModuleCourseModel>? content,
    String? createdAt,
    String? updatedAt,
  }) {
    return ModuleCourseModel(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      order: order ?? this.order,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'subjectId': subjectId,
      'ordenation': order,
      'title': title,
      'description': description,
      'content': content.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ModuleCourseModel(id: $id, subjectId: $subjectId, order: $order, title: $title, description: $description, content: $content, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
