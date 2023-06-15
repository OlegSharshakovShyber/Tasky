import 'package:flutter/material.dart';

class SubTitleHeaderWidget extends StatelessWidget {
  const SubTitleHeaderWidget(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        color: Color(0x4c000000),
        fontSize: 16,
      ),
    );
  }
}
