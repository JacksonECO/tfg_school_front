import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class InputOptionsRegister<T> extends StatelessWidget {
  final String title;
  final String? hintText;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  final T? initialValue;
  final List<DropdownMenuItem<T>>? options;

  const InputOptionsRegister({
    required this.title,
    this.initialValue,
    this.hintText,
    this.options,
    this.onChanged,
    this.validator,
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
            child: Text(
              title,
              style: context.style.poppinsRegular.copyWith(fontSize: 14),
            ),
          ),
          DropdownButtonFormField<T>(
            value: initialValue,
            decoration: InputDecoration(
              hintText: hintText,
              fillColor: context.colors.gray,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
            ),
            items: options,
            onChanged: onChanged,
            validator: validator,
          )
        ],
      ),
    );
  }
}
