import 'dart:convert';

class TextResourceModel {
  String id;
  String type;
  String title;
  String content;
  int moduleId;
  
  TextResourceModel({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    required this.moduleId,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'content': content,
      'moduleId': moduleId,
    };
  }

  factory TextResourceModel.fromMap(Map<String, dynamic> map) {
    return TextResourceModel(
      id: map['id'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      moduleId: map['moduleId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TextResourceModel.fromJson(String source) => TextResourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
