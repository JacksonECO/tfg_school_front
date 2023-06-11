enum WeekDayEnum {
  empty('Nenhum'),
  sunday('Domingo'),
  monday('Segunda-feira'),
  tuesday('Terça-feira'),
  wednesday('Quarta-feira'),
  thursday('Quinta-feira'),
  friday('Sexta-feira'),
  saturday('Sábado');

  final String title;
  const WeekDayEnum(this.title);

  static WeekDayEnum? fromString(String value) {
    try {
      return WeekDayEnum.values.firstWhere(
        (element) => element.name == value || element.title == value,
      );
    } catch (e) {
      return null;
    }
  }

  bool get isEmpty => false;
}
