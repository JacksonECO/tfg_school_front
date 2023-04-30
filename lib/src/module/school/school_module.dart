import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/school/module/login/login_module.dart';

class SchoolModule extends Module {
  static String home = '/school/';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SchoolLoginModule()),

        // ChildRoute('/', child:  (_, __) => const HomePage()),
      ];
}
