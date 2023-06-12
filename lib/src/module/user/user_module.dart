import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:tfg_front/src/module/user/controller/courses_controller.dart';
import 'package:tfg_front/src/module/user/controller/news_controller.dart';
import 'package:tfg_front/src/module/user/pages/course_page.dart';
import 'package:tfg_front/src/module/user/pages/courses_page.dart';
import 'package:tfg_front/src/module/user/pages/news_page.dart';

class UserModule extends Module {
  static const String initialRoute = '/user/';
  static const String registerRoute = '${initialRoute}register';
  static const String newsRoute = '${initialRoute}news';
  static const String coursesRoute = '${initialRoute}courses';
  static const String courseRoute = '${initialRoute}course';

  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => CourseController()),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          initialRoute.split('/user').last,
          child: (_, __) => const CustomPage(body: []),
        ),
        ChildRoute(
          newsRoute.split('/user').last,
          child: (_, args) => NewsPage(
            controller: NewsController(),
          ),
        ),
        ChildRoute(
          coursesRoute.split('/user').last,
          child: (_, args) => CoursesPage(
            controller: CoursesController(),
          ),
        ),
        ChildRoute(
          courseRoute.split('/user').last + '/:id',
          child: (_, args) => CoursePage(
            subjectId: int.parse(args.params['id']),
          ),
        ),
      ];
}
