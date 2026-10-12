import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

import 'app_image.dart';

class AppAvatar extends StatelessWidget {
  final String imageUrl;
  final String fallbackText;
  final double radius;

  const AppAvatar({
    super.key,
    required this.imageUrl,
    required this.fallbackText,
    this.radius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final initials = fallbackText.trim().isNotEmpty
        ? fallbackText.trim()[0].toUpperCase()
        : 'A';

    final fallbackWidget = Center(
      child: Text(
        initials,
        style: TextStyle(
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );

    return ClipOval(
      child: Container(
        width: radius * 2,
        height: radius * 2,
        color: AppColors.primary.withValues(alpha: 0.1),
        child: imageUrl.trim().isNotEmpty
            ? AppImage(
                imageUrl: imageUrl,
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                errorWidget: fallbackWidget,
              )
            : fallbackWidget,
      ),
    );
  }
}

