import 'package:flutter/material.dart';

class TitleHeaderWidget extends StatelessWidget {
  const TitleHeaderWidget(
    this.data, {
    super.key,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: "Roboto",
        fontWeight: FontWeight.w500,
        letterSpacing: 0.50,
      ),
    );
  }
}
