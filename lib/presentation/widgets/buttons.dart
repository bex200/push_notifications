import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';

enum ButtonType { primary, secondary }

class ButtonWidget extends StatelessWidget {
  final ButtonType type;
  final String text;
  final VoidCallback onPressed;
  const ButtonWidget(
      {super.key,
      required this.type,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(isDark),
      child: Text(
        text,
        style: _textStyle(type == ButtonType.primary, isDark),
      ),
    );
  }

  TextStyle _textStyle(bool isPrimary, bool isDark) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: isPrimary
          ? AppColors.globalWhite
          : (isDark ? AppColors.globalWhite : AppColors.lightLableSmall),
    );
  }

  ButtonStyle _buttonStyle(bool isDark) {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.globalAccentBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        );

      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                  color: isDark
                      ? AppColors.globalWhite
                      : AppColors.lightBodyMedium)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        );

      default:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.globalAccentBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        );
    }
  }
}
