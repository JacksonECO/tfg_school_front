import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/module/user/controller/attendance_controller.dart';
import 'package:tfg_front/src/module/user/controller/course_controller.dart';
import 'package:tfg_front/src/module/user/controller/courses_controller.dart';
import 'package:tfg_front/src/module/user/controller/list_attendance_controller.dart';
import 'package:tfg_front/src/module/user/controller/module_course_controller.dart';
import 'package:tfg_front/src/module/user/controller/news_controller.dart';
import 'package:tfg_front/src/module/user/controller/support_controller.dart';
import 'package:tfg_front/src/module/user/pages/course_page.dart';
import 'package:tfg_front/src/module/user/pages/courses_page.dart';
import 'package:tfg_front/src/module/user/pages/list_attendance_page.dart';
import 'package:tfg_front/src/module/user/pages/module_course_page.dart';
import 'package:tfg_front/src/module/user/pages/news_page.dart';
import 'package:tfg_front/src/module/user/pages/support_page.dart';
import 'package:tfg_front/src/module/user/service/module_course_service.dart';

class UserModule extends Module {
  static const String initialRoute = '/user/';
  static const String registerRoute = '${initialRoute}register';
  static const String newsRoute = '${initialRoute}news';
  static const String coursesRoute = '${initialRoute}courses';
  static const String courseRoute = '${initialRoute}course';
  static const String attendanceRoute = '${initialRoute}attendance';
  static const String supportRoute = '${initialRoute}support';

  @override
  List<Bind> get binds => [
        Bind.factory((i) => ModuleCourseService()),
        //
        Bind.lazySingleton((i) => CourseController()),
        Bind.factory((i) => ModuleCouseController()),
        Bind.factory((i) => SupportController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          initialRoute.split('/user').last,
          child: (_, __) => CoursesPage(
            controller: CoursesController(),
          ),
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
          courseRoute.split('/user').last + '2/:id',
          child: (_, args) => CoursePage(
            subjectId: int.parse(args.params['id']),
          ),
        ),
        ChildRoute(
          courseRoute.split('/user').last + '/:id',
          child: (_, args) => ModuleCousePage(
            subjectId: int.parse(args.params['id']),
            subjectName: 'Material',
          ),
        ),
        ChildRoute(
          attendanceRoute.split('/user').last + '/:class/:subject',
          child: (_, args) => ListAttendancePage(
            controller: ListAttendanceController(
              classId: int.parse(args.params['class']),
              subjectId: int.parse(args.params['subject']),
            ),
            attendanceController: AttendanceController.new,
          ),
        ),
        ChildRoute(
          supportRoute.split('/user').last,
          child: (_, args) => const SupportPage(),
        ),
      ];
}
