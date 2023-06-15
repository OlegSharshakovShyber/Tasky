import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(
    this.data, {
    super.key,
        required this.color,
  });

  final String data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: color,
        fontSize: 16,
      ),
    );
  }
}
