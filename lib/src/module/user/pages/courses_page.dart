import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tfg_front/src/components/crud_viewer.dart';
import 'package:tfg_front/src/components/custom_page.dart';
import 'package:tfg_front/src/components/radio_button_group.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/core/helpers/debouncer.dart';
import 'package:tfg_front/src/core/theme/theme_config.dart';
import 'package:tfg_front/src/model/filter_course_enum.dart';
import 'package:tfg_front/src/module/user/controller/courses_controller.dart';
import 'package:tfg_front/src/module/user/wiget/course_item_widget.dart';

class CoursesPage extends StatefulWidget {
  final CoursesController controller;

  const CoursesPage({super.key, required this.controller});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late final ReactionDisposer statusDisposer;
  final searchEC = TextEditingController();
  final debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    statusDisposer = reaction((_) => widget.controller.status, (status) {
      if (status != CoursesStateStatus.initial) {
        setState(() {});
      }
    });
    widget.controller.loadSubjects();
    super.initState();
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      body: [
        CrudViewer(
          hasScroll: false,
          title: 'Meus Cursos',
          hasPadding: false,
          body: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      if (widget.controller.allSubjects.isNotEmpty && !widget.controller.isStudent())
                        RadioButtonGroup(
                          title: 'Turma',
                          filterType: SideFilterCourseEnum.className,
                          controller: widget.controller,
                          options: widget.controller.filterClassOptions,
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (widget.controller.allSubjects.isNotEmpty && widget.controller.isStudent())
                        RadioButtonGroup(
                        title: 'Professor(a)',
                        filterType: SideFilterCourseEnum.teacherName,
                        controller: widget.controller,
                        options: widget.controller.filterTeacherOptions,
                      ),
                        const SizedBox(
                          height: 20,
                        ),
                      RadioButtonGroup(
                        title: 'Data de Modificação',
                        filterType: SideFilterCourseEnum.orderDate,
                        options: const ['Mais Recentes', 'Mais Antigos'],
                        controller: widget.controller,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                        minWidth: 300, maxHeight: context.height - 150),
                    padding: EdgeInsets.all(context.height * .08),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: searchEC,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Icon(Icons.search),
                              ),
                              border: border,
                              enabledBorder: border,
                              focusedBorder: border,
                              errorBorder: border,
                              focusedErrorBorder: border,
                              disabledBorder: border,
                              hintText: 'Buscar Curso...',
                              fillColor: context.colors.darkBackground,
                              filled: true,
                              hintStyle: context.style.poppinsRegular,
                            ),
                            style: context.style.poppinsRegular,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              debouncer.call(() {
                                widget.controller.filterSubjectName = value;
                                widget.controller.filterSubjects();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          widget.controller.status == CoursesStateStatus.loading
                              ? (Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        color: context.colors.primary,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Buscando Cursos...',
                                        style: context.style.poppinsMedium,
                                      ),
                                    ),
                                  ],
                                ))
                              : widget.controller.status ==
                                      CoursesStateStatus.error
                                  ? (Padding(
                                      padding: const EdgeInsets.only(top: 16),
                                      child: Text(
                                        widget.controller.messageError!,
                                        style: context.style.poppinsMedium,
                                      ),
                                    ))
                                  : widget.controller.allSubjects.isEmpty
                                      ? (Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: Text(
                                            'Não há disciplinas para a turma',
                                            style: context.style.poppinsMedium,
                                          ),
                                        ))
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (widget.controller
                                                .isSomeFilterEnabled())
                                              Text(
                                                'Resultados da Busca: ${widget.controller.totalSeachItens}',
                                                style:
                                                    context.style.poppinsMedium,
                                              ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            ...widget
                                                .controller.filteredSubjects
                                                .map((subject) =>
                                                    CourseItemWidget(
                                                        subject: subject))
                                                .toList()
                                          ],
                                        )
                        ],
                      ),
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

  OutlineInputBorder get border =>
      ThemeConfig.border.copyWith(borderRadius: BorderRadius.circular(8));
}
