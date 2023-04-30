import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;

  static String get baseUrl => 'http://localhost:3333/api';

  // static String get nome => const String.fromEnvironment('nome', defaultValue: 'default');
}
