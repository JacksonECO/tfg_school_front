import 'dart:developer';

enum AuthRoleEnum {
  admin('Administrador'),
  teacher('Professor'),
  student('Estudante'),
  tutor('Tutor');

  final String name;
  const AuthRoleEnum(this.name);

  static AuthRoleEnum? fromName(String? valueName) {
    if (valueName == null) return null;
    try {
      return AuthRoleEnum.values.firstWhere((e) {
        return e.name == valueName;
      });
    } catch (e, s) {
      log('AuthRoleEnum.fromName', error: e, stackTrace: s);
      return null;
    }
  }

  @override
  String toString() {
    return name;
  }
}
