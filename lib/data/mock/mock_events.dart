import '../../models/event.dart';

final List<Event> mockEventsList = [
  Event(
    id: 'evt_201',
    title: 'MSAP Annual Alumni Grand Reunion 2026',
    description:
        'Join fellow alumni across batches for an evening of networking, nostalgic campus walks, award presentations, and keynote talks by industry leaders.',
    date: DateTime(2026, 11, 15, 17, 30),
    location: 'Main Campus Auditorium & Gardens, MSAP',
    imageUrl:
        'assets/Gallary/1st Re-Union of Association MSAP Alumni, Manipur at Manipur University Centenary Hall on 11th May, 2025/1.jpg',
    category: 'Reunion',
    isRsvped: true,
    rsvpCount: 142,
  ),
  Event(
    id: 'evt_202',
    title: 'Symposium: Future of Sustainable Urbanism',
    description:
        'A panel discussion exploring Net-Zero architectural design, carbon-neutral building materials, and smart climate adaptation strategies in Indian cities.',
    date: DateTime(2026, 10, 28, 10, 00),
    location: 'Virtual Zoom / MSAP Seminar Hall B',
    imageUrl:
        'assets/Gallary/Alumni Working Group meeting held at Hotel Castle, Imphal on 19th July, 2025/1.jpg',
    category: 'Symposium',
    isRsvped: false,
    rsvpCount: 88,
  ),
  Event(
    id: 'evt_203',
    title: 'Alumni Design Mentorship & Portfolio Review',
    description:
        'Exclusive workshop where senior alumni review graduating students portfolios and offer 1-on-1 career guidance.',
    date: DateTime(2026, 12, 05, 14, 00),
    location: 'MSAP Design Studio 3',
    imageUrl:
        'assets/Gallary/Alumni Working Group meeting at Joysana Retreat, Oinam on 20th July, 2024/1.jpg',
    category: 'Workshop',
    isRsvped: false,
    rsvpCount: 54,
  ),
  Event(
    id: 'evt_204',
    title: 'Heritage Walk & Adaptive Reuse Tour',
    description:
        'Guided architectural walk through historic city quarters showcasing exemplary heritage conservation and adaptive reuse projects.',
    date: DateTime(2026, 12, 18, 08, 30),
    location: 'Old Town Square Heritage Precinct',
    imageUrl:
        'assets/Gallary/50th golden jubilee/SaveClip.App_652681681_17959174805914550_2586455088703413576_n.jpg',
    category: 'Excursion',
    isRsvped: true,
    rsvpCount: 39,
  ),
];
