import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/announcement_card.dart';
import '../../../core/widgets/app_image.dart';
import '../../../data/mock/mock_announcements.dart';
import '../../../models/announcement.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements & Notices'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockAnnouncementsList.length,
        itemBuilder: (context, index) {
          final announcement = mockAnnouncementsList[index];
          return AnnouncementCard(
            announcement: announcement,
            onTap: () => _showAnnouncementDialog(context, announcement),
          );
        },
      ),
    );
  }

  void _showAnnouncementDialog(BuildContext context, Announcement announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  announcement.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                announcement.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Published by ${announcement.author} • ${announcement.publishDate.day}/${announcement.publishDate.month}/${announcement.publishDate.year}',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 12.0),
              if (announcement.imageUrl != null &&
                  announcement.imageUrl!.isNotEmpty) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 180.0,
                    width: double.infinity,
                    color: AppColors.surfaceVariant,
                    child: AppImage(
                      imageUrl: announcement.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
              ],
              const Divider(height: 24.0),
              Text(
                announcement.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        );
      },
    );
  }
}
