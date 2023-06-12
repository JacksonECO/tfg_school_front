import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color color;
  final IconData? icon;
  final Function()? onPressed;

  const CircleButton({super.key, required this.color, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onPressed ?? () {},
          icon: Icon(icon),
        ),
      ),
    );
  }
}
