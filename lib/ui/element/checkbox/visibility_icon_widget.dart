import 'package:flutter/material.dart';
import 'package:tasky/ui/element/checkbox/checkbox_icon_widget.dart';

class VisibilityIconWidget extends StatelessWidget {
  const VisibilityIconWidget(
      this.isChecked, {
        super.key,
        this.onPressed,
      });

  final bool isChecked;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CheckboxIconWidget(
      isChecked,
      isCheckedIcon: Icons.visibility,
      isUncheckedIcon: Icons.visibility_off,
      size: 24,
      color: const Color(0xff007aff),
      onPressed: onPressed,
    );
  }
}