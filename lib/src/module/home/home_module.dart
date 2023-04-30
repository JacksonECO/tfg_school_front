import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/home/page/home_page.dart';

class HomeModule extends Module {
  static String home = '/';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
        // ModuleRoute('/', module: AppModuleDes()),
      ];
}
