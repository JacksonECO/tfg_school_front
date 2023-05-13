import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_exception.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';

class LoginService {
  final _dio = Modular.get<CustomHttp>();

  Future<Map<String, dynamic>?> loginSchool(String email, String password) async =>
      (await _dio.post<Map<String, dynamic>>(
        '/school/login',
        data: {'email': email, 'password': password},
      ))
          .data;

  Future<AuthModel> registerSchool(
    SchoolModel school,
    FileModel? image,
  ) async {
    final Map<String, dynamic>? data = (await _dio.post<Map<String, dynamic>>(
      '/school/register',
      data: {
        ...school.toMap(),
        if (image != null) 'newLogo': image.toMap(),
      },
    ))
        .data;

    if (data == null) {
      throw CustomException(
        message: 'Erro ao registrar escola',
        error: data,
        stackTrace: StackTrace.current,
      );
    }
    return AuthModel.fromMap(data);
  }

  Future<SchoolModel> getSchool() async {
    final response = await _dio.get<Map<String, dynamic>>('/school/me');
    return SchoolModel.fromMap(response.data!);
  }

  loginUser(String email, String password) {}

  Future<Map<String, dynamic>?> registerUser(UserModel user, FileModel? image) async =>
      (await _dio.post<Map<String, dynamic>>(
        '/user/register',
        data: {
          ...user.toMap(),
          if (image != null) 'newLogo': image.toMap(),
        },
      ))
          .data;
}
