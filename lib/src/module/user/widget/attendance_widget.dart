import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/components/button.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/formatter/date_input_formatter.dart';
import 'package:tfg_front/src/module/user/controller/attendance_controller.dart';
import 'package:tfg_front/src/core/helpers/constants.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/widget/table_attendance_users_widget.dart';
import 'package:validatorless/validatorless.dart';

class AttendanceWidget extends StatelessWidget {
  final AttendanceController controller;
  const AttendanceWidget({super.key, required this.controller});

  static Future showModal({
    required AttendanceController attendanceController,
  }) {
    return showDialog(
      context: Constants.context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1400, maxHeight: context.height * 0.95),
            child: AttendanceWidget(
              controller: attendanceController,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: controller.future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: SelectableText(
                'Erro ao carregar dados',
                style: context.style.interRegular.copyWith(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                ),
                padding: const EdgeInsets.fromLTRB(28, 32, 32, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SelectableText(
                          controller.newAttendance ? 'Cadastrar Presenças' : 'Editar Presenças',
                          style: context.style.poppinsRegular.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SelectableText(
                          'Preencha com os dados abaixo',
                          style: context.style.interRegular.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/img/register-user.png',
                      height: 116,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Form(
                  key: controller.form,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: InputRegister(
                                title: 'Data  da Aula',
                                initialValue: controller.attendanceModel.dateString,
                                onChanged: (v) => controller.attendanceModel.dateString = v,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Campo obrigatório'),
                                  DateInputFormatter.validator,
                                ]),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  DateInputFormatter(),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: InputRegister(
                                title: 'Quantidade de aulas',
                                initialValue: controller.attendanceModel.totalLesson?.toString() ?? '1',
                                onChanged: (v) => controller.attendanceModel.totalLesson = int.tryParse(v) ?? 1,
                                validator: Validatorless.required('Campo obrigatório'),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Flexible(
                          child: SingleChildScrollView(
                            child: TableAttendanceUsersWidget(controller: controller),
                          ),
                        ),
                        Button(
                          text: 'Salvar Presenças',
                          borderRadius: 15,
                          onPressed: controller.save,
                          color: context.colors.primary,
                          height: 45,
                          withBorder: false,
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
