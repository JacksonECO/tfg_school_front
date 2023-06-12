import 'dart:convert';

class FileResourceModel {
  String id;
  String title;
  String type;
  String typeFile;
  String link;
  int moduleId;
  
  FileResourceModel({
    required this.id,
    required this.title,
    required this.type,
    required this.typeFile,
    required this.link,
    required this.moduleId,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'type': type,
      'typeFile': typeFile,
      'link': link,
      'moduleId': moduleId,
    };
  }

  factory FileResourceModel.fromMap(Map<String, dynamic> map) {
    return FileResourceModel(
      id: map['id'] as String,
      title: map['title'] as String,
      type: map['type'] as String,
      typeFile: map['typeFile'] as String,
      link: map['link'] as String,
      moduleId: map['moduleId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileResourceModel.fromJson(String source) => FileResourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
