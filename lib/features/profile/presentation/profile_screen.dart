import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/profile_header.dart';
import '../../../data/mock/user_profile_store.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileStore _profileStore = UserProfileStore.instance;

  @override
  void initState() {
    super.initState();
    _profileStore.addListener(_onProfileUpdated);
  }

  @override
  void dispose() {
    _profileStore.removeListener(_onProfileUpdated);
    super.dispose();
  }

  void _onProfileUpdated() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = _profileStore.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Header Widget
            ProfileHeader(
              profile: currentProfile,
              onEditPressed: () => context.push(AppConstants.routeEditProfile),
            ),
            const SizedBox(height: 20.0),

            // Profile Options Menu
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  _buildProfileTile(
                    icon: Icons.person_outline_rounded,
                    title: 'Edit Personal Details',
                    subtitle: 'Update phone, role, company, location',
                    onTap: () => context.push(AppConstants.routeEditProfile),
                  ),
                  const Divider(height: 1, indent: 54, endIndent: 16),
                  _buildProfileTile(
                    icon: Icons.receipt_long_outlined,
                    title: 'Payments & Membership Dues',
                    subtitle: 'View active status and transaction records',
                    onTap: () => context.push(AppConstants.routePayments),
                  ),
                  const Divider(height: 1, indent: 54, endIndent: 16),
                  _buildProfileTile(
                    icon: Icons.photo_library_outlined,
                    title: 'Alumni Photo Gallery',
                    subtitle: 'Browse reunion and campus event memories',
                    onTap: () => context.push(AppConstants.routeGallery),
                  ),
                  const Divider(height: 1, indent: 54, endIndent: 16),
                  _buildProfileTile(
                    icon: Icons.feedback_outlined,
                    title: 'Contact & Feedback',
                    subtitle: 'Reach out to MSAP executive committee',
                    onTap: () => context.push(AppConstants.routeFeedback),
                  ),
                  const Divider(height: 1, indent: 54, endIndent: 16),
                  _buildProfileTile(
                    icon: Icons.info_outline_rounded,
                    title: 'About MSAP Alumni',
                    subtitle: 'Association vision, executive board, & app info',
                    onTap: () => context.push(AppConstants.routeAbout),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Authentication Action Card
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error, width: 1.0),
                minimumSize: const Size.fromHeight(48.0),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Sign Out'),
                    content: const Text('Are you sure you want to sign out of MSAP Alumni?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          context.go(AppConstants.routeLogin);
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded, size: 18.0),
              label: const Text('Sign Out'),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20.0),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12.0, color: AppColors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20.0),
    );
  }
}
