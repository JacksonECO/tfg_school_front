import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/custom_http.dart';
import 'package:tfg_front/src/model/service_model.dart';

class ResetPasswordService {
  final _dio = Modular.get<CustomHttp>();

  Future<ServiceModel> preResetPassword(String email, bool isSchool) async {
    try {
      final result = await _dio.post(
        '/pre-reset-password/',
        data: {
          'email': email,
          'isSchool': isSchool,
        },
      );
      return ServiceModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log(
        'Erro ao configurar redefiição de senha',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro ao configurar redefiição de senha');
    }
  }

  Future<ServiceModel> resetPassword(
      String newPassword, String resetToken) async {
    try {
      final result = await _dio.post(
        '/reset-password/',
        data: {
          'resetToken': resetToken,
          'newPassword': newPassword,
        },
      );
      return ServiceModel.fromMap(result.data);
    } on DioError catch (e, s) {
      log(
        'Erro ao redefinir a senha',
        error: e,
        stackTrace: s,
      );
      throw Exception('Erro ao redefinir a senha');
    }
  }
}
