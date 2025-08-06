import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? bakgroundColor;
  final Widget child;
  const CustomButton({super.key, this.onTap, this.bakgroundColor, required this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bakgroundColor ?? AppColors.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      child: child,
    );
  }
}
