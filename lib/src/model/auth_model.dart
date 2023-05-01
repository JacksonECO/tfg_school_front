import 'dart:convert';

import 'package:sweet_cookie/sweet_cookie.dart';

import 'package:tfg_front/src/model/auth_role_enum.dart';

class AuthModel {
  int? userId;
  int? schoolId;
  String? name;
  String? email;
  String? photoUrl;
  AuthRoleEnum? authRole;
  String? tokenJwt;

  AuthModel({
    this.userId,
    this.schoolId,
    this.name,
    this.email,
    this.photoUrl,
    this.authRole,
    this.tokenJwt,
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
      'authRole': authRole?.name,
      'tokenJwt': tokenJwt,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      userId: map['userId'] as int?,
      schoolId: map['schoolId'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      photoUrl: map['photoUrl'] as String?,
      authRole: AuthRoleEnum.fromName(map['authRole'] as String?),
      tokenJwt: map['tokenJwt'] as String? ?? map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(userId: $userId, schoolId: $schoolId, name: $name, email: $email, photoUrl: $photoUrl, authRole: $authRole, tokenJwt: $tokenJwt)';
  }

  void clear() {
    userId = null;
    schoolId = null;
    name = null;
    email = null;
    photoUrl = null;
    authRole = null;
    tokenJwt = null;
    SweetCookie.clear();
  }

  void set(AuthModel user) async {
    userId = user.userId;
    schoolId = user.schoolId;
    name = user.name;
    email = user.email;
    photoUrl = user.photoUrl;
    authRole = user.authRole;
    tokenJwt = user.tokenJwt;

    updateStorage();
  }

  void updateStorage() => SweetCookie.set('auth', toJson());
}
