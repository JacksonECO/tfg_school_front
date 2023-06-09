import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/src/model/auth_model.dart';
import 'package:tfg_front/web_module.dart';

Future<void> main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    AuthModel.sharedPreferences = await SharedPreferences.getInstance();
  }

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
    // GoogleFonts.config.allowRuntimeFetching = false;
    Modular.setNavigatorKey(Constants.navigatorKey);

    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..loadingStyle = EasyLoadingStyle.dark;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'School',
      debugShowCheckedModeBanner: false,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeConfig.defaultTheme,
      builder: EasyLoading.init(),
    );
  }
}
