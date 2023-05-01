import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';

class LoginService {
  final _dio = Modular.get<CustomHttp>();

  Future<void> loginSchool(String email, String password) async {
    await _dio.post(
      '/school/login',
      data: {'email': email, 'password': password},
    );
  }

  Future<void> registerSchool(SchoolModel school, FileModel? image) async {
    await _dio.post(
      '/school/register',
      data: {
        ...school.toMap(),
        if (image != null) 'newLogo': image.toMap(),
      },
    );
  }

  loginUser(String email, String password) {}
}
