import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class RadioButtonGroup extends StatefulWidget {
  final List<String> options;
  final String title;
  const RadioButtonGroup(
      {super.key, required this.options, required this.title});

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
            title: Text(e,
                style: context.style.poppinsLight.copyWith(
                  fontSize: 16,
                )),
            leading: Radio<String>(
              value: e,
              groupValue: _value,
              onChanged: (String? value) {
                setState(() {
                  _value = value;
                });
              },
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: context.style.poppinsMedium.copyWith(
              fontSize: 16,
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
