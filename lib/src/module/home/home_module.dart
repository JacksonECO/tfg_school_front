import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/home/controller/login_controller.dart';
import 'package:tfg_front/src/module/home/page/home_page.dart';
import 'package:tfg_front/src/module/home/page/login_page.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String loginSchoolRoute = '/login-school';
  static const String loginUserRoute = '/login-user';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        // ChildRoute(
        //   '/',
        //   child: (_, __) => LoginPage(
        //     controller: LoginController(isSchool: true),
        //   ),
        // ),
        ChildRoute(
          loginSchoolRoute,
          child: (_, __) => LoginPage(
            controller: LoginController(isSchool: true),
          ),
        ),
        ChildRoute(
          loginUserRoute,
          child: (_, __) => LoginPage(
            controller: LoginController(isSchool: false),
          ),
        ),
      ];
}
