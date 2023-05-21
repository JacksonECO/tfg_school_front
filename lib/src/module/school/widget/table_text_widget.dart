import 'package:flutter/material.dart';

class TableTextWidget extends StatelessWidget {
  final String text;
  final bool isHeader;
  const TableTextWidget(
    this.text, {
    this.isHeader = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      constraints: const BoxConstraints(minHeight: 50),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
      ),
    );
  }
}
