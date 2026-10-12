import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget childWidget = isLoading
        ? SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == AppButtonType.primary
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18.0),
                const SizedBox(width: 8.0),
              ],
              Text(text),
            ],
          );

    final buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(width ?? double.infinity, height),
    );

    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton(
          style: buttonStyle,
          onPressed: isLoading ? null : onPressed,
          child: childWidget,
        );
      case AppButtonType.secondary:
        return ElevatedButton(
          style: buttonStyle.copyWith(
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: isLoading ? null : onPressed,
          child: childWidget,
        );
      case AppButtonType.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
          ),
          onPressed: isLoading ? null : onPressed,
          child: childWidget,
        );
      case AppButtonType.text:
        return TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(width ?? double.infinity, height),
          ),
          onPressed: isLoading ? null : onPressed,
          child: childWidget,
        );
    }
  }
}
