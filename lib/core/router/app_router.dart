import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../widgets/main_scaffold.dart';
import '../../features/about/presentation/about_screen.dart';
import '../../features/alumni/presentation/alumni_detail_screen.dart';
import '../../features/alumni/presentation/alumni_search_screen.dart';
import '../../features/announcements/presentation/announcements_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/events/presentation/event_detail_screen.dart';
import '../../features/events/presentation/events_screen.dart';
import '../../features/feedback/presentation/feedback_screen.dart';
import '../../features/gallery/presentation/gallery_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/payments/presentation/payments_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppConstants.routeHome,
  routes: [
    // Auth Routes outside main shell
    GoRoute(
      path: AppConstants.routeLogin,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppConstants.routeRegister,
      builder: (context, state) => const RegisterScreen(),
    ),

    // Stateful Navigation Shell for 4 Main Tabs
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppConstants.routeHome,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),

        // Tab 1: Alumni Search Directory
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppConstants.routeAlumni,
              builder: (context, state) => const AlumniSearchScreen(),
            ),
          ],
        ),

        // Tab 2: Events
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppConstants.routeEvents,
              builder: (context, state) => const EventsScreen(),
            ),
          ],
        ),

        // Tab 3: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppConstants.routeProfile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),

    // Secondary Detail & Modal Routes
    GoRoute(
      path: '${AppConstants.routeAlumniDetail}/:id',
      builder: (context, state) {
        final alumniId = state.pathParameters['id'] ?? '';
        return AlumniDetailScreen(alumniId: alumniId);
      },
    ),
    GoRoute(
      path: '${AppConstants.routeEventDetail}/:id',
      builder: (context, state) {
        final eventId = state.pathParameters['id'] ?? '';
        return EventDetailScreen(eventId: eventId);
      },
    ),
    GoRoute(
      path: AppConstants.routeAnnouncements,
      builder: (context, state) => const AnnouncementsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeGallery,
      builder: (context, state) => const GalleryScreen(),
    ),
    GoRoute(
      path: AppConstants.routePayments,
      builder: (context, state) => const PaymentsScreen(),
    ),
    GoRoute(
      path: AppConstants.routeEditProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppConstants.routeFeedback,
      builder: (context, state) => const FeedbackScreen(),
    ),
    GoRoute(
      path: AppConstants.routeAbout,
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
