import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:msap_alumni/data/mock/events_store.dart';
import 'package:msap_alumni/data/mock/mock_announcements.dart';
import 'package:msap_alumni/data/mock/mock_events.dart';
import 'package:msap_alumni/data/mock/mock_gallery.dart';
import 'package:msap_alumni/data/mock/mock_leadership.dart';
import 'package:msap_alumni/data/mock/user_profile_store.dart';
import 'package:msap_alumni/features/about/presentation/about_screen.dart';
import 'package:msap_alumni/main.dart';
import 'package:msap_alumni/models/leadership_member.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _MockHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _MockHttpClientResponse implements HttpClientResponse {
  static final List<int> _transparentImage = <int>[
    0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
    0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
    0x0A, 0x49, 0x44, 0x52, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05,
    0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45,
    0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
  ];

  @override
  int get statusCode => 200;

  @override
  int get contentLength => _transparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    void Function()? onDone,
    Function? onError,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable(<List<int>>[_transparentImage]).listen(
      onData,
      onDone: onDone,
      onError: onError,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  setUp(() {
    UserProfileStore.instance.reset();
    EventsStore.instance.reset();
  });

  testWidgets('MSAP Alumni App renders home screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MSAPAlumniApp());
    await tester.pumpAndSettle();

    // Verify app home screen renders user name & quick navigation items
    expect(find.textContaining('Hello,'), findsOneWidget);
    expect(find.text('Notices'), findsOneWidget);
    expect(find.text('Upcoming Events'), findsOneWidget);
    expect(find.text('Featured Memories'), findsOneWidget);
  });

  test('Mock Gallery data includes all 40 photographs across 5 categories', () {
    expect(mockGalleryList.length, 40);
    final categories = mockGalleryList.map((g) => g.category).toSet();
    expect(categories.contains('Reunion'), isTrue);
    expect(categories.contains('Get Together'), isTrue);
    expect(categories.contains('Annual General Meeting'), isTrue);
    expect(categories.contains('Golden Jubilee'), isTrue);
    expect(categories.contains('Working Group'), isTrue);
  });

  test('Mock Leadership data includes all 15 General Body members with real assets', () {
    expect(mockLeadershipList.length, 15);
    for (final member in mockLeadershipList) {
      expect(member.imagePath.startsWith('assets/General Body/'), isTrue);
    }
  });

  test('Leadership hierarchy verifies 5 Office Bearers, 7 Executive Members, and 3 Advisors', () {
    final ob = mockLeadershipList.where((m) => m.category == LeadershipCategory.officeBearer).toList();
    final em = mockLeadershipList.where((m) => m.category == LeadershipCategory.executiveMember).toList();
    final ab = mockLeadershipList.where((m) => m.category == LeadershipCategory.advisoryBoard).toList();

    expect(ob.length, 5);
    expect(em.length, 7);
    expect(ab.length, 3);

    // Verify President is Prof. (Dr.) Th. Asha Sinha
    expect(ob.first.name, 'Prof. (Dr.) Th. Asha Sinha');
    expect(ob.first.role, 'President');

    // Verify specific office bearers
    expect(ob[1].name, 'Col. Shantikumar Sapam, Retd.');
    expect(ob[2].name, 'Mr. Kulabidhu Chanam');
    expect(ob[3].name, 'Nangngom Jotindra Luwang, Adv.');
    expect(ob[4].name, 'Mr. Jhaljit Ningthemcha');
  });

  test('Mock Events data uses real MSAP asset paths', () {
    for (final event in mockEventsList) {
      expect(event.imageUrl.startsWith('assets/'), isTrue);
    }
  });

  test('Mock Announcements data includes news image paths', () {
    final pinned = mockAnnouncementsList.where((a) => a.isPinned).toList();
    expect(pinned.isNotEmpty, isTrue);
    expect(pinned.any((a) => a.imageUrl != null && a.imageUrl!.startsWith('assets/News/')), isTrue);
  });

  test('EventsStore updates RSVP state and attendee count reactively', () {
    final store = EventsStore.instance;
    final firstEvent = store.events.first;
    final initialRsvp = firstEvent.isRsvped;
    final initialCount = firstEvent.rsvpCount;

    final updatedRsvp = store.toggleRsvp(firstEvent.id);
    expect(updatedRsvp, !initialRsvp);

    final updatedEvent = store.getEventById(firstEvent.id);
    expect(updatedEvent, isNotNull);
    expect(updatedEvent!.isRsvped, !initialRsvp);
    expect(updatedEvent.rsvpCount, initialRsvp ? initialCount - 1 : initialCount + 1);
  });

  test('UserProfileStore updates local mock profile correctly', () {
    final store = UserProfileStore.instance;
    final originalName = store.currentUser.name;

    final updated = store.currentUser.copyWith(
      name: 'Dr. Ananya Sharma',
      currentRole: 'Principal Architect & Urban Planner',
    );
    store.updateProfile(updated);

    expect(store.currentUser.name, 'Dr. Ananya Sharma');
    expect(store.currentUser.currentRole, 'Principal Architect & Urban Planner');

    store.reset();
    expect(store.currentUser.name, originalName);
  });

  testWidgets('Navigation to Alumni tab and batch/query filtering works', (WidgetTester tester) async {
    await tester.pumpWidget(const MSAPAlumniApp());
    await tester.pumpAndSettle();

    // Tap Alumni tab in NavigationBar
    await tester.tap(find.text('Alumni'));
    await tester.pumpAndSettle();

    expect(find.text('Alumni Directory'), findsOneWidget);
    expect(find.text('Found 6 Alumni'), findsOneWidget);

    // Filter by search query
    await tester.enterText(find.byType(TextField).first, 'Sneha');
    await tester.pumpAndSettle();

    expect(find.text('Found 1 Alumni'), findsOneWidget);
    expect(find.text('Sneha Kulkarni'), findsOneWidget);
    expect(find.text('Rohan Verma'), findsNothing);

    // Clear filter
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle();
    expect(find.text('Found 6 Alumni'), findsOneWidget);
  });

  testWidgets('AboutScreen renders all 7 required sections properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AboutScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Section A: About MSAP
    expect(find.text('About MSAP'), findsOneWidget);
    expect(find.text('Est. 1973'), findsOneWidget);

    // Section B: Our Heritage (Timeline)
    expect(find.text('Our Heritage'), findsOneWidget);
    expect(find.text('Foundation of MSAP'), findsOneWidget);
    expect(find.text('Golden Jubilee Celebration'), findsOneWidget);

    // Section C: Office Bearers
    expect(find.text('Office Bearers'), findsOneWidget);
    expect(find.text('Prof. (Dr.) Th. Asha Sinha'), findsOneWidget);
    expect(find.text('PRESIDENT'), findsOneWidget);
    expect(find.text('Col. Shantikumar Sapam, Retd.'), findsOneWidget);
    expect(find.text('Mr. Kulabidhu Chanam'), findsOneWidget);
    expect(find.text('Nangngom Jotindra Luwang, Adv.'), findsOneWidget);
    expect(find.text('Mr. Jhaljit Ningthemcha'), findsOneWidget);

    // Section D: Executive Members
    expect(find.text('Executive Members'), findsOneWidget);

    // Section E: Advisory Board
    expect(find.text('Advisory Board'), findsOneWidget);
    expect(find.text('Hon\'ble MLA Th. Arunkumar'), findsOneWidget);

    // Section F: Mission
    expect(find.text('Our Mission'), findsOneWidget);

    // Section G: Registration Details
    expect(find.text('Governance & Registration'), findsOneWidget);
    expect(find.text('Imphal, Manipur & Pune, Maharashtra, India'), findsOneWidget);
  });
}
