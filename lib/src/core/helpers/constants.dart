import 'package:flutter/material.dart';

class Constants {
  Constants._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;

  static bool get prod => const bool.fromEnvironment('prod', defaultValue: false);
  static String get baseUrl =>
      const String.fromEnvironment('urlBase', defaultValue: 'https://back-escola.fly.dev/api');

  static String get emailSchool => const String.fromEnvironment('emailSchool');
  static String get emailUser => const String.fromEnvironment('emailSchool');
  static String get password => const String.fromEnvironment('password');
  // static String get nome => const String.fromEnvironment('nome', defaultValue: 'default');
}
