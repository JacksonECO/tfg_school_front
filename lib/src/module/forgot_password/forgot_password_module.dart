import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/forgot_password/controller/forgot_password_controller.dart';
import 'package:tfg_front/src/module/forgot_password/page/sended_email_page.dart';
import 'package:tfg_front/src/module/forgot_password/page/forgot_password_page.dart';
import 'package:tfg_front/src/service/reset_password_service.dart';

class ForgotPasswordModule extends Module {
  static const String schoolInitialRoute = '/forgot-password/school';
  static const String userInitialRoute = '/forgot-password/user';
  static const String emailSendedRoute = '/forgot-password/sended-email';

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ResetPasswordService()),
        Bind.lazySingleton((i) => ForgotPasswordController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/user',
            child: (context, args) =>
                const ForgotPasswordPage(isSchool: false)),
        ChildRoute('/school',
            child: (context, args) => const ForgotPasswordPage(isSchool: true)),
        ChildRoute('/sended-email',
            child: (context, args) => const ConfirmResetEmail()),
      ];
}
