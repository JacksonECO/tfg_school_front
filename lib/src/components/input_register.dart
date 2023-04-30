import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class InputRegister extends StatelessWidget {
  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const InputRegister({
    required this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 4),
            child: Text(title),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: initialValue,
            onChanged: onChanged,
            onTap: onTap,
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: context.colors.gray,
              filled: true,
            ),
            validator: validator,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }
}
