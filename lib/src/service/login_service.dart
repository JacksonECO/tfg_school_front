import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/file_model.dart';
import 'package:tfg_front/src/module/school/model/school_model.dart';

class LoginService {
  final _dio = Modular.get<CustomHttp>();

  Future<Map<String, dynamic>?> loginSchool(String email, String password) async =>
      (await _dio.post<Map<String, dynamic>>(
        '/school/login',
        data: {'email': email, 'password': password},
      ))
          .data;

  Future<Map<String, dynamic>?> registerSchool(
    SchoolModel school,
    FileModel? image,
  ) async =>
      (await _dio.post<Map<String, dynamic>>(
        '/school/register',
        data: {
          ...school.toMap(),
          if (image != null) 'newLogo': image.toMap(),
        },
      ))
          .data;

  Future<SchoolModel> getSchool() async {
    final response = await _dio.get<Map<String, dynamic>>('/school/me');
    return SchoolModel.fromMap(response.data!);
  }

  loginUser(String email, String password) {}
  // Future<Map<String, dynamic>?> registerUser(UserModel user, FileModel? image) async{}
}
