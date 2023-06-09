import 'package:flutter/material.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class BulletListItem extends StatelessWidget {
  final String text;
  const BulletListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          const Text(
            "\u2022",
            style: TextStyle(fontSize: 22),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: context.style.poppinsRegular.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
