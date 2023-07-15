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
  final Color? prefixColor;
  final bool enabled;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;

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
    this.onFieldSubmitted,
    this.prefixColor,
    this.enabled = true,
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
            padding: const EdgeInsets.only(left: 2, bottom: 4),
            child: SelectableText(
              title,
              style: context.style.poppinsRegular.copyWith(fontSize: 14),
            ),
          ),
          TextFormField(
            enabled: enabled,
            readOnly: onTap != null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: initialValue,
            onChanged: onChanged,
            onTap: onTap,
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5.0),
              ),
              hintText: hintText,
              fillColor: context.colors.gray,
              filled: true,
              prefixIcon: prefixColor != null ? const Icon(Icons.circle) : null,
              prefixIconColor: prefixColor,
            ),
            validator: validator,
            inputFormatters: inputFormatters,
            style: context.style.poppinsRegular,
          ),
        ],
      ),
    );
  }
}
