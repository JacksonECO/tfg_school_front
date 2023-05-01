import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:tfg_front/src/module/school/page/home_page.dart';
import 'package:tfg_front/src/module/school/page/register_page.dart';

class SchoolModule extends Module {
  static const String initialRoute = '/school/';
  static const String registerRoute = '${initialRoute}register';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          initialRoute.split('/school').last,
          child: (_, __) => HomePage(
            controllerProfile: ProfileController(newSchool: false),
          ),
        ),
        ChildRoute(
          registerRoute.split('/school').last,
          child: (_, __) => RegisterPage(
            controller: ProfileController(),
          ),
        ),
      ];
}
