import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/mock/events_store.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;

  const EventDetailScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final EventsStore _eventsStore = EventsStore.instance;

  @override
  void initState() {
    super.initState();
    _eventsStore.addListener(_onStoreUpdated);
  }

  @override
  void dispose() {
    _eventsStore.removeListener(_onStoreUpdated);
    super.dispose();
  }

  void _onStoreUpdated() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final event = _eventsStore.getEventById(widget.eventId);

    if (event == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Event Details'),
        ),
        body: EmptyStateWidget(
          icon: Icons.event_busy_outlined,
          title: 'Event Not Found',
          message: 'The requested event could not be found or has been removed.',
          actionLabel: 'Back to Events',
          onActionPressed: () => context.pop(),
        ),
      );
    }

    final isRsvped = event.isRsvped;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share Event',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Event details for "${event.title}" copied to clipboard.'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Banner
            Container(
              height: 200.0,
              width: double.infinity,
              color: AppColors.surfaceVariant,
              child: AppImage(
                imageUrl: event.imageUrl,
                fit: BoxFit.cover,
                errorWidget: Container(
                  color: AppColors.primaryDark,
                  alignment: Alignment.center,
                  child: const Icon(Icons.event, color: Colors.white38, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Date Badge Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          event.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.people_outline, size: 16.0, color: AppColors.textSecondary),
                          const SizedBox(width: 4.0),
                          Text(
                            '${event.rsvpCount} Attending',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),

                  // Title
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20.0),

                  // Date & Time Card
                  _buildDetailTile(
                    context,
                    icon: Icons.calendar_today_rounded,
                    title: 'Date & Time',
                    subtitle:
                        '${event.date.day}/${event.date.month}/${event.date.year} at ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')} IST',
                  ),
                  const SizedBox(height: 12.0),

                  // Location Card
                  _buildDetailTile(
                    context,
                    icon: Icons.location_on_rounded,
                    title: 'Location / Venue',
                    subtitle: event.location,
                  ),
                  const SizedBox(height: 24.0),

                  // Description
                  Text(
                    'About this Event',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32.0),

                  // RSVP Action Button
                  AppButton(
                    text: isRsvped ? 'Cancel RSVP' : 'Confirm RSVP & Attend',
                    type: isRsvped ? AppButtonType.outlined : AppButtonType.primary,
                    icon: isRsvped ? Icons.cancel_outlined : Icons.check_circle_outline,
                    onPressed: () {
                      final updatedRsvp = _eventsStore.toggleRsvp(event.id);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            updatedRsvp
                                ? 'RSVP confirmed for ${event.title}! You\'re on the attendee list.'
                                : 'RSVP cancelled for ${event.title}.',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
