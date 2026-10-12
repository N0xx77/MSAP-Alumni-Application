import 'package:flutter/material.dart';
import '../../models/event.dart';
import '../theme/app_colors.dart';

import 'app_image.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;
  final VoidCallback? onRsvpTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.onRsvpTap,
  });

  @override
  Widget build(BuildContext context) {
    final monthString = _getMonthAbbr(event.date.month);
    final dayString = event.date.day.toString().padLeft(2, '0');

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image Banner with Date Overlay & Category Badge
            Stack(
              children: [
                Container(
                  height: 140.0,
                  width: double.infinity,
                  color: AppColors.surfaceVariant,
                  child: AppImage(
                    imageUrl: event.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: Container(
                      color: AppColors.primaryDark,
                      alignment: Alignment.center,
                      child: const Icon(Icons.event, color: Colors.white38, size: 40),
                    ),
                  ),
                ),
                // Date Badge
                Positioned(
                  top: 12.0,
                  left: 12.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dayString,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          monthString.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 12.0,
                  right: 12.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      event.category,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Details Body
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 15.0, color: AppColors.textSecondary),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          event.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${event.rsvpCount} Alumni Attending',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                      InkWell(
                        onTap: onRsvpTap ?? onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: event.isRsvped ? AppColors.successBackground : AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: event.isRsvped ? AppColors.success : AppColors.primary,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                event.isRsvped ? Icons.check_circle : Icons.bookmark_add_outlined,
                                size: 14.0,
                                color: event.isRsvped ? AppColors.success : AppColors.primary,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                event.isRsvped ? 'Attending' : 'RSVP',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: event.isRsvped ? AppColors.success : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthAbbr(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }
}
