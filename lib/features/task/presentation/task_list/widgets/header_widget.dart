import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.expandedHeight,
    required this.title,
    this.background,
    this.actions,
  });

  final double expandedHeight;
  final Widget? title;
  final Widget? background;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 16,
      pinned: true,
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        centerTitle: false,
        titlePadding: const EdgeInsetsDirectional.only(
          start: 16.0,
          bottom: 16.0,
          top: 16.0,
        ),
        title: title,
        background: background,
      ),
      actions: actions,
    );
  }
}
