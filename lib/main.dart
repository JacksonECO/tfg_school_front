import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/web_module.dart';

void main() {
  runApp(ModularApp(
    module: WebModule(),
    child: const Web(),
  ));
}

class Web extends StatelessWidget {
  const Web({super.key});

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
