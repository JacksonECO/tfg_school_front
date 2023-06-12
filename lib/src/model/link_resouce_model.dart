import 'dart:convert';

class LinkResourceModel {
  String id;
  String type;
  String title;
  String link;
  int moduleId;
  
  LinkResourceModel({
    required this.id,
    required this.type,
    required this.title,
    required this.link,
    required this.moduleId,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'link': link,
      'moduleId': moduleId,
    };
  }

  factory LinkResourceModel.fromMap(Map<String, dynamic> map) {
    return LinkResourceModel(
      id: map['id'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      link: map['link'] as String,
      moduleId: map['moduleId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinkResourceModel.fromJson(String source) => LinkResourceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
