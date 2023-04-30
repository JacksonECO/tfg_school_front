import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:tfg_front/src/module/school/page/register_page.dart';
import 'package:tfg_front/src/module/school/service/login_service.dart';

class SchoolModule extends Module {
  static String home = '/school/';
  static String register = '${home}register';

  @override
  List<Bind> get binds => [
        Bind((i) => SchoolProfileService()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/register',
          child: (_, __) => RegisterPage(
            controller: ProfileController(),
          ),
        ),
      ];
}
