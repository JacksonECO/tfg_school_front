import 'package:flutter/material.dart';

class TableTextWidget extends StatelessWidget {
  final String text;
  final bool isHeader;
  final Alignment alignment;
  const TableTextWidget(
    this.text, {
    this.isHeader = false,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      constraints: const BoxConstraints(minHeight: 50),
      alignment: alignment,
      child: Text(
        text,
        textAlign: TextAlign.start,
      ),
    );
  }
}

class TableRowWidget extends StatelessWidget {
  final Widget child;
  final bool isHeader;
  final Alignment alignment;
  const TableRowWidget(
    this.child, {
    this.isHeader = false,
    this.alignment = Alignment.centerLeft,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      constraints: const BoxConstraints(minHeight: 50),
      alignment: alignment,
      child: child,
    );
  }
}
