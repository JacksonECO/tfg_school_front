import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/components/input_options_register.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/hour_input_formatter.dart';
import 'package:tfg_front/src/model/date_custom.dart';
import 'package:tfg_front/src/model/week_day_enum.dart';
import 'package:tfg_front/src/module/school/controller/class_controller.dart';
import 'package:validatorless/validatorless.dart';

class PeriodLineSubjectWidget extends StatelessWidget {
  final int index;
  final int subjectIndex;
  final DateCustom dateCustom;
  final ClassController controller;
  final ValueNotifier notifier;

  const PeriodLineSubjectWidget({
    required this.dateCustom,
    required this.index,
    required this.controller,
    required this.notifier,
    required this.subjectIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: InputOptionsRegister<WeekDayEnum>(
            title: 'Dia da semana',
            hintText: 'Dia da semana',
            options: WeekDayEnum.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.title),
                    ))
                .toList(),
            initialValue: dateCustom.weekDay ?? WeekDayEnum.empty,
            onChanged: (v) {
              dateCustom.weekDay = v;
              controller.addPeriod(subjectIndex);
              notifier.value = controller.classModel.subjects[subjectIndex].dateCustom?.length ?? 0;
            },
            validator: Validatorless.required('Campo obrigatório'),
          ),
        ),
        const SizedBox(width: 22),
        Flexible(
          child: InputRegister(
            title: 'Horário de Início',
            hintText: 'Horário de Início',
            initialValue: dateCustom.start,
            onChanged: (v) => dateCustom.start = v,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              HourInputFormatter(),
            ],
            validator: (a) {
              if (dateCustom.isEmpty) return null;
              return HourInputFormatter.validator(a);
            },
          ),
        ),
        const SizedBox(width: 22),
        Flexible(
          child: InputRegister(
            title: 'Horário de Término',
            hintText: 'Horário de Término',
            initialValue: dateCustom.end,
            onChanged: (v) => dateCustom.end = v,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              HourInputFormatter(),
            ],
            validator: (a) {
              if (dateCustom.isEmpty) return null;
              return HourInputFormatter.validator(a);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 4),
          child: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              controller.removePeriod(subjectIndex, index);
              notifier.value = controller.classModel.subjects[subjectIndex].dateCustom?.length ?? 0;
            },
          ),
        ),
      ],
    );
  }
}
