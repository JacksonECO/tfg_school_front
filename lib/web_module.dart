import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/src/core/helpers/custom_http_dio.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';
import 'package:tfg_front/src/service/login_service.dart';
import 'package:tfg_front/src/service/user_service.dart';

class WebModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => CustomHttpDio()),
        Bind.factory((i) => ImagePicker()),
        Bind.factory((i) => LoginService()),
        Bind.factory((i) => UserService()),
        Bind.singleton((i) => AuthModel.cookie())
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/school', module: SchoolModule()),
        ModuleRoute('/user', module: UserModule()),
      ];
}
