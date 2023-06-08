import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/radio_button_group.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/module/user/controller/courses_controller.dart';

class CoursesPage extends StatelessWidget {
  final CoursesController controller;

  const CoursesPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        CrudViewer(
          title: 'Meus Cursos',
          hasPadding: false,
          body: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(context.width * 0.02),
                  width: context.width * .2,
                  height: context.height - 150,
                  decoration: BoxDecoration(
                    color: context.colors.darkBackground,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Filtros',
                        style: context.style.poppinsSemiBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const RadioButtonGroup(
                        title: 'Ano Escolar',
                        options: ['Terceiro', 'Segundo', 'Primeiro'],
                      ),
                      const SizedBox(
                         height: 20,
                      ),
                      const RadioButtonGroup(
                        title: 'Data de Modificação',
                        options: ['Mais Recentes', 'Mais Antigos'],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text('Disciplina'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
