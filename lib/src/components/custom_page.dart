import 'package:flutter/material.dart';
import 'package:tfg_front/src/components/footer_widget.dart';
import 'package:tfg_front/src/components/header_widget.dart';

class CustomPage extends StatelessWidget {
  final List<Widget>? body;
  final List<Widget>? slivers;
  final PreferredSizeWidget? appBar;
  final Widget? footer;

  const CustomPage({
    this.appBar,
    this.body,
    this.slivers,
    this.footer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      body: CustomScrollView(
        slivers: [
          if (body != null) ...[
            SliverToBoxAdapter(
              child: Column(
                children: body!,
              ),
            )
          ],
          if (slivers != null) ...slivers!,
          SliverFillRemaining(
            hasScrollBody: false,
            child: footer ?? const FooterWidget(),
          ),
        ],
      ),
    );
  }
}
