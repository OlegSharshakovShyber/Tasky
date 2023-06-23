import 'package:flutter/material.dart';

class CheckboxIconWidget extends StatelessWidget {
  const CheckboxIconWidget(
    this.isChecked, {
    super.key,
    required this.isCheckedIcon,
    required this.isUncheckedIcon,
    this.size,
    this.color,
    this.onPressed,
  });

  final bool isChecked;
  final IconData isCheckedIcon;
  final IconData isUncheckedIcon;
  final double? size;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isChecked ? isCheckedIcon : isUncheckedIcon,
        size: size,
        color: color,
      ),
    );
  }
}
