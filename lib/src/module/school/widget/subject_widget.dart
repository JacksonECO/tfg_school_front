import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tfg_front/src/components/input_options_register.dart';
import 'package:tfg_front/src/components/input_register.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/subject_model.dart';
import 'package:tfg_front/src/model/user_model.dart';
import 'package:tfg_front/src/module/school/controller/class_controller.dart';
import 'package:tfg_front/src/module/school/widget/period_line_subject_widget.dart';
import 'package:validatorless/validatorless.dart';

class SubjectWidget extends StatefulWidget {
  final int index;
  final SubjectModel subject;
  final bool isExpanded;
  final ClassController controller;

  const SubjectWidget({
    required this.index,
    required this.subject,
    required this.controller,
    this.isExpanded = true,
    super.key,
  });

  @override
  _SubjectWidgetState createState() => _SubjectWidgetState();
}

class _SubjectWidgetState extends State<SubjectWidget> with TickerProviderStateMixin {
  late AnimationController expandController;
  late AnimationController iconController;

  late Animation<double> expandAnimation;
  late Animation<double> iconAnimation;

  late ValueNotifier<int> countPeriod;

  late TextEditingController colorController;

  late bool expand;

  @override
  void initState() {
    super.initState();
    expand = widget.isExpanded;
    colorController = TextEditingController(text: widget.subject.color);
    if (widget.subject.times == null || widget.subject.times!.isEmpty) {
      widget.controller.addPeriod(widget.index);
    }

    countPeriod = ValueNotifier(widget.subject.times?.length ?? 0)
      ..addListener(() {
        setState(() {});
      });

    prepareAnimations();
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    iconController.dispose();
    countPeriod.dispose();
    colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Disciplina ${widget.index + 1}',
              style: context.style.interSemiBold.copyWith(fontSize: 14),
            ),
            const Spacer(),
            IconButton(
              icon: RotationTransition(
                turns: iconController,
                child: RotationTransition(
                  turns: iconController,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                  ),
                ),
              ),
              onPressed: () {
                expand = !expand;
                _runExpandCheck();
              },
            ),
          ],
        ),
        const Divider(color: Colors.white, height: 20),
        SizeTransition(
          sizeFactor: expandAnimation,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: InputRegister(
                      title: 'Nome',
                      hintText: 'Nome',
                      initialValue: widget.subject.name,
                      onChanged: (v) => widget.subject.name = v,
                      validator: Validatorless.required('Campo obrigatório'),
                    ),
                  ),
                  const SizedBox(width: 22),
                  Flexible(
                    child: Observer(builder: (_) {
                      return InputRegister(
                        title: 'Cor',
                        hintText: 'Cor',
                        controller: colorController,
                        validator: Validatorless.required('Campo obrigatório'),
                        prefixColor: widget.controller.classModel.subjects[widget.index].toColor,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: 390,
                                  child: HueRingPicker(
                                    pickerColor: widget.subject.toColor,
                                    onColorChanged: (v) {
                                      String value = '#' +
                                          v.value.toRadixString(16).substring(2).toUpperCase();

                                      widget.controller.classModel.subjects[widget.index].color =
                                          value;
                                      colorController.text = value;
                                    },
                                    enableAlpha: false,
                                    portraitOnly: true,
                                    displayThumbColor: true,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));
                        },
                      );
                    }),
                  ),
                  const SizedBox(width: 22),
                  Flexible(
                    child: Observer(builder: (_) {
                      return InputOptionsRegister<UserModel>(
                        title: 'Professor',
                        hintText: 'Professor',
                        options: widget.controller.teachers
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name ?? ''),
                                ))
                            .toList(),
                        initialValue: widget.controller.getTeacher(widget.index),
                        onChanged: (v) => widget.controller.setTeacher(widget.index, v),
                        validator: Validatorless.required('Campo obrigatório'),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.subject.times?.length ?? 0,
                itemBuilder: (context, index) {
                  return PeriodLineSubjectWidget(
                    key: Key(index.toString()),
                    index: index,
                    subjectIndex: widget.index,
                    dateCustom: widget.subject.times![index],
                    notifier: countPeriod,
                    controller: widget.controller,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      value: expand ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 750),
    );
    expandAnimation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );

    iconController = AnimationController(
      vsync: this,
      value: expand ? 1.0 : 0.0,
      upperBound: 0.75,
      duration: const Duration(milliseconds: 500),
    );
    iconAnimation = CurvedAnimation(
      parent: iconController,
      curve: Curves.easeInOutBack,
    );
  }

  void _runExpandCheck() {
    if (expand) {
      expandController.forward();
      iconController.forward();
    } else {
      expandController.reverse();
      iconController.reverse();
    }
  }

  @override
  void didUpdateWidget(SubjectWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }
}
