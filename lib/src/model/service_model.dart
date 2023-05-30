import 'dart:convert';

class ServiceModel {
  final bool error;
  final String message; 
  ServiceModel({
    required this.error,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      error: map['error'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) => ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
