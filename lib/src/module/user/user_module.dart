import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_interfaces/src/route/modular_key.dart';
import 'package:tfg_front/src/components/custom_page.dart';

class UserModule extends Module {
  static String home = '/user/';

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        // ModuleRoute('/', module: AppModuleDes()),

        ChildRoute(
          '/',
          child: (_, __) => CustomPage(body: [
            Text('User'),
          ]),
        ),
      ];
}
