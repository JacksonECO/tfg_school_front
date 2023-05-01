import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/src/model/auth_role_enum.dart';
import 'package:tfg_front/src/module/school/school_module.dart';
import 'package:tfg_front/src/module/user/user_module.dart';
import 'package:tfg_front/web_module.dart';

void main() {
  runApp(ModularApp(
    module: WebModule(),
    child: const Web(),
  ));
}

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  @override
  void initState() {
    super.initState();
    final user = Modular.get<AuthModel>();

    switch (user.authRole) {
      case AuthRoleEnum.admin:
        Modular.to.navigate(SchoolModule.initialRoute);
        break;
      case AuthRoleEnum.teacher:
      case AuthRoleEnum.student:
      case AuthRoleEnum.tutor:
        Modular.to.navigate(UserModule.initialRoute);
        break;
      default:
        Modular.to.navigate('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    // GoogleFonts.config.allowRuntimeFetching = false;
    Modular.setNavigatorKey(Constants.navigatorKey);

    return MaterialApp.router(
      title: 'School',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeConfig.defaultTheme,
    );
  }
}
