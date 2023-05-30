
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/service_model.dart';
import 'package:tfg_front/src/service/reset_password_service.dart';
part 'reset_password_controller.g.dart';

enum ResetPasswordStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ResetPasswordController = ResetPasswordControllerBase
    with _$ResetPasswordController;

abstract class ResetPasswordControllerBase with Store {
  final ResetPasswordService _service = Modular.get<ResetPasswordService>();

  @readonly
  var _status = ResetPasswordStateStatus.initial;

  @readonly
  String? _message;

  final form = GlobalKey<FormState>();

  late String newPassword;

  String? verifyPassword(String? confirmPassword) {
    if (newPassword != confirmPassword) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  @action
  Future<void> resetPassowrd(String resetToken) async {
    if (form.currentState!.validate()) {
      _status = ResetPasswordStateStatus.loading;
      ServiceModel serviceResetPassword =
          await _service.resetPassword(newPassword, resetToken);
      if (serviceResetPassword.error) {
        _status = ResetPasswordStateStatus.error;
      } else {
        _status = ResetPasswordStateStatus.loaded;
      }
      _message = serviceResetPassword.message;
    }
  }

  void goToHome() {
    return Modular.to.navigate('/');
  }
}
