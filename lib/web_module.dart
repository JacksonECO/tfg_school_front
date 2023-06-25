import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tfg_front/mocks/services/attendance_service_mock.dart';
import 'package:tfg_front/src/core/helpers/custom_http_dio.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/module/forgot_password/forgot_password_module.dart';
import 'package:tfg_front/src/module/home/home_module.dart';
import 'package:tfg_front/src/module/reset_password/reset_password_module.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';
import 'package:tfg_front/src/service/class_service.dart';
import 'package:tfg_front/src/service/login_service.dart';
import 'package:tfg_front/src/service/module_course_service.dart';
import 'package:tfg_front/src/service/news_service.dart';
import 'package:tfg_front/src/service/subject_service.dart';
import 'package:tfg_front/src/service/user_service.dart';

class WebModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => CustomHttpDio()),
        Bind.factory((i) => ImagePicker()),
        Bind.factory((i) => LoginService()),
        Bind.factory((i) => UserService()),
        Bind.factory((i) => ClassService()),
        Bind.factory((i) => NewsService()),
        Bind.factory((i) => SubjectService()),
        Bind.factory((i) => AttendanceServiceMock()),
        Bind.factory((i) => ModuleCourseService()),
        Bind.singleton((i) => AuthModel.cookie()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule(), transition: TransitionType.noTransition),
        ModuleRoute('/school', module: SchoolModule(), transition: TransitionType.noTransition),
        ModuleRoute('/user', module: UserModule(), transition: TransitionType.noTransition),
        ModuleRoute('/forgot-password',
            module: ForgotPasswordModule(), transition: TransitionType.noTransition),
        ModuleRoute('/reset-password',
            module: ResetPasswordModule(), transition: TransitionType.noTransition),
      ];
}
