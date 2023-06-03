import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/model/service_model.dart';
import 'package:tfg_front/src/service/reset_password_service.dart';
part 'forgot_password_controller.g.dart';

enum ForgotPasswordStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ForgotPasswordController = ForgotPasswordControllerBase with _$ForgotPasswordController;

abstract class ForgotPasswordControllerBase with Store {
  final ResetPasswordService _service = Modular.get<ResetPasswordService>();

  @readonly
  var _status = ForgotPasswordStateStatus.initial;

  @readonly
  String? _message;

  late String email;

  final form = GlobalKey<FormState>();

  @action
  Future<void> preResetPassword(bool isSchool) async {
    if (form.currentState!.validate()) {
      try {
        _status = ForgotPasswordStateStatus.loading;
        ServiceModel serviceForgotPassword = await _service.preResetPassword(
          email,
          isSchool,
        );

        if (serviceForgotPassword.error) {
          _status = ForgotPasswordStateStatus.error;
        } else {
          _status = ForgotPasswordStateStatus.loaded;
        }
        _message = serviceForgotPassword.message;
      } catch (e) {
        _status = ForgotPasswordStateStatus.error;
      }
    }
  }
}
