import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';
import 'package:tfg_front/src/model/filter_course_enum.dart';
import 'package:tfg_front/src/module/user/controller/courses_controller.dart';

class RadioButtonGroup extends StatefulWidget {
  final List<String> options;
  final String title;
  final SideFilterCourseEnum filterType;
  final CoursesController controller;

  const RadioButtonGroup({
    super.key,
    required this.options,
    required this.title,
    required this.filterType,
    required this.controller,
  });

  @override
  State<RadioButtonGroup> createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    List<ListTile> group = widget.options
        .map(
          (e) => ListTile(
            title: SelectableText(e,
                style: context.style.poppinsLight.copyWith(
                  fontSize: 14,
                )),
            leading: Radio<String>(
              value: e,
              activeColor: MaterialStateColor.resolveWith((states) => context.colors.primary),
              groupValue: _value,
              onChanged: (String? value) {
                setState(() {
                  _value = value;
                });
                if (value != null) {
                  switch (widget.filterType) {
                    case SideFilterCourseEnum.teacherName:
                      widget.controller.filterTeacherName = value;
                      break;
                    case SideFilterCourseEnum.className:
                      widget.controller.filterClassName = value;
                      break;
                    case SideFilterCourseEnum.orderDate:
                      widget.controller.filterOrderDate = value;
                      break;
                  }
                  widget.controller.filterSubjects();
                }
              },
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SelectableText(
            widget.title,
            style: context.style.poppinsMedium.copyWith(
              fontSize: 14,
            ),
          ),
        ),
        const Divider(
          color: Colors.white70,
          thickness: 2,
        ),
        ...group,
      ],
    );
  }
}
