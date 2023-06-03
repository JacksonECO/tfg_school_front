import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweet_cookie/sweet_cookie.dart';
import 'package:tfg_front/src/components/leading_menu_widget.dart';

import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/school_module.dart';

class AuthModel {
  static SharedPreferences? sharedPreferences;

  int? userId;
  String? userName;
  String? userPhoto;

  int? schoolId;
  String? schoolName;
  String? schoolLogo;

  String? email;
  AuthRoleEnum? role;
  String? token;

  AuthModel({
    this.userId,
    this.userName,
    this.userPhoto,
    this.schoolId,
    this.schoolName,
    this.schoolLogo,
    this.email,
    this.role,
    this.token,
  });

  factory AuthModel.cookie() {
    final String? cookie = kIsWeb ? SweetCookie.get('auth') : sharedPreferences?.getString('auth');
    if (cookie == null) return AuthModel();
    return AuthModel.fromJson(cookie);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'schoolId': schoolId,
      'schoolName': schoolName,
      'schoolLogo': schoolLogo,
      'email': email,
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
      userName: map['userName'] as String?,
      userPhoto: photo,
      schoolId: map['schoolId'] as int?,
      schoolName: map['schoolName'] as String?,
      schoolLogo: map['schoolLogo'] as String?,
      email: map['email'] as String?,
      role: AuthRoleEnum.fromName(map['role'] as String?),
      token: map['token'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthModel(userId: $userId, schoolId: $schoolId)';
  }

  void clear() {
    userId = null;
    userName = null;
    userPhoto = null;

    schoolId = null;
    schoolName = null;
    schoolLogo = null;

    email = null;
    role = null;
    token = null;

    if (kIsWeb) {
      sharedPreferences?.clear();
    } else {
      sharedPreferences?.remove('auth');
    }
  }

  void set(AuthModel user) async {
    userId = user.userId;
    userName = user.userName;
    userPhoto = user.userPhoto;

    schoolId = user.schoolId;
    schoolName = user.schoolName;
    schoolLogo = user.schoolLogo;

    email = user.email;
    role = user.role;
    token = user.token;

    updateStorage();
  }

  void updateStorage() {
    if (kIsWeb) {
      SweetCookie.set('auth', toJson());
    } else {
      sharedPreferences?.setString('auth', toJson());
    }
  }

  LeadingMenu get leadingMenuObjectList {
    final menu = LeadingMenu();

    menu.top.addAll([
      LeadingMenuItem(
        title: schoolName ?? '',
        icon: Image.network(schoolLogo!, height: 32, width: 32),
        canSelect: false,
      ),
      LeadingMenuItem(
        title: 'Página Inicial',
        route: userId == null ? '/school/' : '/user/',
        icon: Image.asset('assets/icon/home.png', height: 28, width: 28),
      ),
    ]);
    menu.bottom.addAll([
      LeadingMenuItem(
        title: 'Sair',
        icon: Image.asset('assets/icon/power-off.png', height: 28, width: 28),
      ),
      if (role != AuthRoleEnum.admin)
        LeadingMenuItem(
          title: userName ?? '',
          subTitle: email ?? '',
          icon: CircleAvatar(
            backgroundImage: NetworkImage(userPhoto!),
            radius: 14,
          ),
        ),
    ]);

    switch (role) {
      case AuthRoleEnum.teacher:
      case AuthRoleEnum.tutor:
        break;
      case AuthRoleEnum.admin:
        menu.top.addAll([
          LeadingMenuItem(
            title: 'Professores',
            route: SchoolModule.listTeacherRoute,
            icon: Image.asset('assets/icon/teacher.png', height: 28, width: 28),
          ),
          LeadingMenuItem(
            title: 'Alunos',
            route: SchoolModule.listStudentsRoute,
            icon: Image.asset('assets/icon/student-with-book.png', height: 28, width: 28),
          ),
          LeadingMenuItem(
            title: 'Turmas',
            route: SchoolModule.listClassRoute,
            icon: Image.asset('assets/icon/class.png', height: 28, width: 28),
          ),
        ]);
        break;
      case AuthRoleEnum.student:
        menu.top.addAll([
          LeadingMenuItem(
            title: 'Notícias',
            route: '/',
            icon: Image.asset('assets/icon/alert.png', height: 28, width: 28),
          ),
          LeadingMenuItem(
            title: 'Meus Curso',
            route: '/',
            icon: Image.asset('assets/icon/courses-icon.png', height: 28, width: 28),
          ),
          LeadingMenuItem(
            title: 'Cronograma',
            route: '/',
            icon: Image.asset('assets/icon/schedule.png', height: 28, width: 28),
          ),
          LeadingMenuItem(
            title: 'Suporte ',
            route: '/',
            icon: Image.asset('assets/icon/suporte.png', height: 28, width: 28),
          ),
        ]);
        break;
      default:
        break;
    }

    return menu;
  }
}
