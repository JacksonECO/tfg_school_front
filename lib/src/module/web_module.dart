import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/src/core/helpers/custom_http_dio.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';

import 'home/page/home_page.dart';

class WebModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => CustomHttpDio()),
        Bind.factory((i) => ImagePicker()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/school', module: SchoolModule()),
        ModuleRoute('/user', module: UserModule()),
        ChildRoute('/', child: (_, __) => const HomePage()),
      ];
}
