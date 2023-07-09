import 'package:flutter/widgets.dart';
import 'package:tfg_front/src/core/helpers/context_extension.dart';

class CustomWrap extends StatelessWidget {
  final double minRow;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomWrap({
    super.key,
    required this.children,
    this.minRow = 1000,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  Column get column {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Row get row {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (minRow >= context.width) {
      return column;
    }
    return row;
  }
}
