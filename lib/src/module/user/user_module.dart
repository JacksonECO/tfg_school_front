import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/custom_page.dart';

class UserModule extends Module {
  static const String initialRoute = '/user/';
  static const String registerRoute = '/user/';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        // ModuleRoute('/', module: AppModuleDes()),
        ChildRoute(
          initialRoute.split('/user').last,
          child: (_, __) => const CustomPage(body: []),
        ),
      ];
}
