import 'package:flutter/material.dart';

class Click extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const Click({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}
