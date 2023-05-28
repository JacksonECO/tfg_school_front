import 'dart:convert';

import 'package:sweet_cookie/sweet_cookie.dart';

import 'package:tfg_front/src/model/auth_role_enum.dart';

class AuthModel {
  int? userId;
  int? schoolId;
  String? name;
  String? email;
  String? photoUrl;
  AuthRoleEnum? role;
  String? token;

  AuthModel({
    this.userId,
    this.schoolId,
    this.name,
    this.email,
    this.photoUrl,
    this.role,
    this.token,
  });

  factory AuthModel.cookie() {
    final cookie = SweetCookie.get('auth');
    if (cookie == null) return AuthModel();
    return AuthModel.fromJson(cookie);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'schoolId': schoolId,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role?.name,
      'token': token,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    String? photo;
    if (map['photoUrl'] is String?) {
      photo = map['photoUrl'] as String?;
    } else {
      photo = map['photoUrl']['url'];
    }

    return AuthModel(
      userId: map['userId'] as int?,
      schoolId: map['schoolId'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      photoUrl: photo,
      role: AuthRoleEnum.fromName(map['role'] as String?),
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(userId: $userId, schoolId: $schoolId, name: $name, email: $email, photoUrl: $photoUrl, role: $role, token: $token)';
  }

  void clear() {
    userId = null;
    schoolId = null;
    name = null;
    email = null;
    photoUrl = null;
    role = null;
    token = null;
    SweetCookie.clear();
  }

  void set(AuthModel user) async {
    userId = user.userId;
    schoolId = user.schoolId;
    name = user.name;
    email = user.email;
    photoUrl = user.photoUrl;
    role = user.role;
    token = user.token;

    updateStorage();
  }

  void updateStorage() => SweetCookie.set('auth', toJson());
}
