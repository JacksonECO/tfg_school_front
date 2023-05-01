enum AuthRoleEnum {
  admin('Administrador'),
  teacher('Professor'),
  student('Estudante'),
  tutor('Tutor');

  const AuthRoleEnum(String name);

  static AuthRoleEnum? fromName(String? valueName) {
    if (valueName == null) return null;
    try {
      return AuthRoleEnum.values.firstWhere((e) => e.name == valueName);
    } catch (_) {
      return null;
    }
  }

  @override
  String toString() {
    return name;
  }
}
