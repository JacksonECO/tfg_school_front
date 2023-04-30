import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/school/module/login/login_controller.dart';
import 'package:tfg_front/src/module/school/module/login/login_page.dart';
import 'package:tfg_front/src/module/school/module/login/login_service.dart';

class SchoolLoginModule extends Module {
  static String home = '/school/login/';

  @override
  List<Bind> get binds => [
        Bind((i) => SchoolLoginService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => SchoolLoginPage(
            controller: SchoolLoginController(),
          ),
        ),
      ];
}
