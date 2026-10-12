import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/mock/mock_alumni.dart';
import '../../../models/alumni.dart';

class AlumniDetailScreen extends StatelessWidget {
  final String alumniId;

  const AlumniDetailScreen({
    super.key,
    required this.alumniId,
  });

  @override
  Widget build(BuildContext context) {
    Alumni? alumni;
    try {
      alumni = mockAlumniList.firstWhere((a) => a.id == alumniId);
    } catch (_) {
      alumni = null;
    }

    if (alumni == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Alumni Details'),
        ),
        body: EmptyStateWidget(
          icon: Icons.person_off_outlined,
          title: 'Alumni Not Found',
          message: 'The requested alumni profile could not be located in the directory.',
          actionLabel: 'Back to Directory',
          onActionPressed: () => context.pop(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alumni Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Cover Banner & Avatar
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120.0,
                  width: double.infinity,
                  color: AppColors.primary,
                ),
                Positioned(
                  bottom: -40.0,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: AppAvatar(
                      radius: 44.0,
                      imageUrl: alumni.avatarUrl,
                      fallbackText: alumni.name,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0),

            // Name & Title Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    alumni.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${alumni.currentRole} at ${alumni.company}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16.0, color: AppColors.textSecondary),
                      const SizedBox(width: 4.0),
                      Text(
                        alumni.location,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Batch Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Batch of ${alumni.graduationYear} • ${alumni.department}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24.0),

            // Bio & Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    alumni.bio,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),

                  Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12.0),
                  _buildContactTile(
                    context,
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: alumni.email,
                  ),
                  _buildContactTile(
                    context,
                    icon: Icons.link,
                    label: 'LinkedIn Profile',
                    value: alumni.linkedInUrl,
                  ),

                  const SizedBox(height: 32.0),

                  AppButton(
                    text: 'Send Message / Connect',
                    icon: Icons.send_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Direct messaging with ${alumni?.name} will be enabled once backend messaging service is connected.',
                          ),
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

  Widget _buildContactTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 18.0, color: AppColors.primary),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11.0, color: AppColors.textMuted),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
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
