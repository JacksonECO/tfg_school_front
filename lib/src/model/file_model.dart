// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class FileModel {
  String? data; // Upload
  Uint8List? image; // Memory
  String? url; // Download

  String? mimeType;
  String? name;

  FileModel({
    this.data,
    this.image,
    this.url,
    this.mimeType,
    this.name,
  });

  static Future<FileModel> fromPicker(XFile file) async {
    final bytes = await file.readAsBytes();

    return FileModel()
      ..data = base64.encode(bytes)
      ..name = file.name.split('scaled_').last
      ..image = bytes
      ..mimeType = file.mimeType;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (data != null) 'data': data,
      if (url != null) 'url': url,
      'mimeType': mimeType,
      'name': name,
    };
  }

  factory FileModel.fromMap(Map<String, dynamic> map) {
    return FileModel(
      url: map['url'] != null ? map['url'] as String : null,
      mimeType: map['mimeType'] != null ? map['mimeType'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileModel.fromJson(String source) =>
      FileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FileModel(data: $data, image: $image, url: $url, mimeType: $mimeType, name: $name)';
  }

  @override
  bool operator ==(covariant FileModel other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.image == image &&
        other.url == url &&
        other.mimeType == mimeType &&
        other.name == name;
  }

  @override
  int get hashCode {
    return data.hashCode ^ image.hashCode ^ url.hashCode ^ mimeType.hashCode ^ name.hashCode;
  }
}
