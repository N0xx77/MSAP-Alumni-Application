import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/alumni_card.dart';
import '../../../core/widgets/announcement_card.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../core/widgets/app_image.dart';
import '../../../core/widgets/event_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../data/mock/events_store.dart';
import '../../../data/mock/mock_alumni.dart';
import '../../../data/mock/mock_announcements.dart';
import '../../../data/mock/mock_gallery.dart';
import '../../../data/mock/user_profile_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserProfileStore _profileStore = UserProfileStore.instance;
  final EventsStore _eventsStore = EventsStore.instance;

  @override
  void initState() {
    super.initState();
    _profileStore.addListener(_onStateUpdated);
    _eventsStore.addListener(_onStateUpdated);
  }

  @override
  void dispose() {
    _profileStore.removeListener(_onStateUpdated);
    _eventsStore.removeListener(_onStateUpdated);
    super.dispose();
  }

  void _onStateUpdated() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _profileStore.currentUser;
    final eventsList = _eventsStore.events;
    final pinnedAnnouncement = mockAnnouncementsList.firstWhere(
      (a) => a.isPinned,
      orElse: () => mockAnnouncementsList.first,
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16.0,
        title: Row(
          children: [
            AppAvatar(
              radius: 18.0,
              imageUrl: currentUser.avatarUrl,
              fallbackText: currentUser.name,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${currentUser.name.split(' ').first}!',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  currentUser.membershipStatus,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Announcements',
            onPressed: () => context.push(AppConstants.routeAnnouncements),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MSAP Alumni Hero / Branding Banner
            Container(
              width: double.infinity,
              height: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const AppImage(
                      imageUrl: 'assets/homepage.png',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                          stops: [0.45, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12.0,
                      left: 14.0,
                      right: 14.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppConstants.associationTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(color: Colors.black54, blurRadius: 4),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            AppConstants.tagLine,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Quick Navigation Shortcuts Grid
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildQuickActionItem(
                    context,
                    icon: Icons.campaign_rounded,
                    label: 'Notices',
                    color: const Color(0xFFE0F2FE),
                    iconColor: const Color(0xFF0284C7),
                    onTap: () => context.push(AppConstants.routeAnnouncements),
                  ),
                  _buildQuickActionItem(
                    context,
                    icon: Icons.photo_library_rounded,
                    label: 'Gallery',
                    color: const Color(0xFFFEF3C7),
                    iconColor: const Color(0xFFD97706),
                    onTap: () => context.push(AppConstants.routeGallery),
                  ),
                  _buildQuickActionItem(
                    context,
                    icon: Icons.payments_rounded,
                    label: 'Pay Dues',
                    color: const Color(0xFFDCFCE7),
                    iconColor: const Color(0xFF15803D),
                    onTap: () => context.push(AppConstants.routePayments),
                  ),
                  _buildQuickActionItem(
                    context,
                    icon: Icons.rate_review_rounded,
                    label: 'Feedback',
                    color: const Color(0xFFF3E8FF),
                    iconColor: const Color(0xFF7E22CE),
                    onTap: () => context.push(AppConstants.routeFeedback),
                  ),
                  _buildQuickActionItem(
                    context,
                    icon: Icons.info_outline_rounded,
                    label: 'About',
                    color: const Color(0xFFF1F5F9),
                    iconColor: const Color(0xFF475569),
                    onTap: () => context.push(AppConstants.routeAbout),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Pinned Announcement Banner
            SectionHeader(
              title: 'Important Notice',
              actionLabel: 'View All',
              onActionPressed: () => context.push(AppConstants.routeAnnouncements),
            ),
            AnnouncementCard(
              announcement: pinnedAnnouncement,
              onTap: () => context.push(AppConstants.routeAnnouncements),
            ),
            const SizedBox(height: 16.0),

            // Featured Gallery Preview Carousel Section
            SectionHeader(
              title: 'Featured Memories',
              subtitle: 'Recent reunions and general body gatherings',
              actionLabel: 'View All',
              onActionPressed: () => context.push(AppConstants.routeGallery),
            ),
            SizedBox(
              height: 140.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mockGalleryList.take(6).length,
                itemBuilder: (context, index) {
                  final item = mockGalleryList[index];
                  return Container(
                    width: 200.0,
                    margin: const EdgeInsets.only(right: 12.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => context.push(AppConstants.routeGallery),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            AppImage(
                              imageUrl: item.imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black87],
                                  stops: [0.4, 1.0],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8.0,
                              left: 8.0,
                              right: 8.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.category,
                                    style: const TextStyle(
                                      fontSize: 9.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2.0),
                                  Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),

            // Upcoming Events Section
            SectionHeader(
              title: 'Upcoming Events',
              subtitle: 'Connect and participate in MSAP reunions',
              actionLabel: 'Explore All',
              onActionPressed: () => context.go(AppConstants.routeEvents),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: eventsList.take(2).length,
              itemBuilder: (context, index) {
                final event = eventsList[index];
                return EventCard(
                  event: event,
                  onTap: () => context.push('${AppConstants.routeEventDetail}/${event.id}'),
                  onRsvpTap: () {
                    final newRsvp = _eventsStore.toggleRsvp(event.id);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          newRsvp
                              ? 'RSVP confirmed for "${event.title}". You\'re attending!'
                              : 'RSVP removed for "${event.title}".',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16.0),

            // Featured Alumni Section
            SectionHeader(
              title: 'Alumni Spotlight',
              subtitle: 'Meet distinguished members of our network',
              actionLabel: 'Search Directory',
              onActionPressed: () => context.go(AppConstants.routeAlumni),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mockAlumniList.take(3).length,
              itemBuilder: (context, index) {
                final alumni = mockAlumniList[index];
                return AlumniCard(
                  alumni: alumni,
                  onTap: () => context.push('${AppConstants.routeAlumniDetail}/${alumni.id}'),
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 22.0),
            ),
            const SizedBox(height: 6.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
