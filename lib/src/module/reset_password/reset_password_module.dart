import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/reset_password/controller/reset_password_controller.dart';
import 'package:tfg_front/src/module/reset_password/page/reset_password_page.dart';
import 'package:tfg_front/src/service/reset_password_service.dart';

class ResetPasswordModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ResetPasswordService()),
        Bind.lazySingleton((i) => ResetPasswordController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/:resetToken',
          child: (context, args) =>
              ResetPasswordPage(resetToken: args.params['resetToken']),
        )
      ];
}
