import 'package:flutter/material.dart';

import 'package:tfg_front/src/components/leading_menu_widget.dart';

class CustomPage extends StatelessWidget {
  final List<Widget>? body;
  final List<Widget>? slivers;
  final PreferredSizeWidget? appBar;
  final Widget? footer;
  final Widget? leading;

  final bool showLeading;
  final bool showAppBar;
  final bool showFooter;
  final Widget? floatingActionButton;

  const CustomPage({
    this.body,
    this.slivers,
    this.appBar,
    this.footer,
    this.leading,
    this.floatingActionButton,
    this.showLeading = true,
    this.showAppBar = false,
    this.showFooter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      body: CustomScrollView(
        slivers: [
          if (body != null) ...[
            SliverToBoxAdapter(
              child: showLeading
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          leading ?? const LeadingMenuWidget(),
                          Expanded(
                            child: Column(
                              children: body!,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: body!,
                    ),
            )
          ],
          // if (slivers != null) ...slivers!,
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: footer ?? (showFooter ? const FooterWidget() : null),
          // ),
        ],
      ),
    );
  }
}
