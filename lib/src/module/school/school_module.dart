import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/controller/list_users_controller.dart';
import 'package:tfg_front/src/module/school/controller/profile_controller.dart';
import 'package:tfg_front/src/module/school/controller/profile_user_controller.dart';
import 'package:tfg_front/src/module/school/page/home_page.dart';
import 'package:tfg_front/src/module/school/page/list_users_page.dart';
import 'package:tfg_front/src/module/school/page/profile_user_page.dart';
import 'package:tfg_front/src/module/school/page/register_page.dart';

class SchoolModule extends Module {
  static const String initialRoute = '/school/';
  static const String registerRoute = '${initialRoute}register';

  /// Param: id
  static const String studentRoute = '${initialRoute}student';
  static const String listStudentsRoute = '${initialRoute}listStudents';
  static const String listTeacherRoute = '${initialRoute}listTeacher';
  static const String listClassRoute = '${initialRoute}listClass';
  static const String listDisciplinaRoute = '${initialRoute}listDisciplina';

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
        ChildRoute(
          studentRoute.split('/school').last + '/:id',
          child: (_, args) => ProfileUserPage(
            controller: ProfileUserController(
              userId: int.tryParse(args.params['id']),
              isStudent: true,
            ),
          ),
        ),
        ChildRoute(
          listStudentsRoute.split('/school').last,
          child: (_, args) => ListUsersPage(
            controller: ListUsersController(typeUser: AuthRoleEnum.student),
            profileUserControllerType: ProfileUserController.new,
          ),
        ),
        ChildRoute(
          listTeacherRoute.split('/school').last,
          child: (_, args) => ListUsersPage(
            controller: ListUsersController(typeUser: AuthRoleEnum.teacher),
            profileUserControllerType: ProfileUserController.new,
          ),
        ),
      ];
}
