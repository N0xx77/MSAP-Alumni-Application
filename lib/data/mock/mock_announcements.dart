import '../../models/announcement.dart';

final List<Announcement> mockAnnouncementsList = [
  Announcement(
    id: 'anc_304',
    title: 'MSAP Alumni Annual General Body Meeting (AGM) Notice',
    summary:
        'Official notice regarding the upcoming Annual General Body Meeting, executive committee reports, and organizational roadmap.',
    content:
        'The Annual General Body Meeting of the MSAP Alumni Association brings together alumni and executive leadership to review annual reports, deliberate on key organizational milestones, approve financial statements, and plan upcoming initiatives.',
    publishDate: DateTime(2026, 09, 01),
    category: 'Governance',
    author: 'Executive Committee',
    isPinned: true,
    imageUrl: 'assets/News/Annual Body Meeting.jpeg',
  ),
  Announcement(
    id: 'anc_305',
    title: 'MSAP Alumni New Year Get-Together Celebration',
    summary:
        'Warm greetings and celebration gathering for all MSAP alumni members and families.',
    content:
        'The MSAP Alumni Association invites all members to celebrate the New Year with fellowship, interactive sharing, and networking. Join us as we look forward to stronger community bonds and collaborative endeavors in the coming year.',
    publishDate: DateTime(2026, 01, 04),
    category: 'Community',
    author: 'Secretary MSAPAA',
    isPinned: true,
    imageUrl: 'assets/News/new year.jpeg',
  ),
  Announcement(
    id: 'anc_301',
    title: 'Nominations Open: Distinguished Alumni Excellence Awards 2026',
    summary:
        'Submit your nominations for outstanding contributions in architecture, research, urban planning, and community service.',
    content:
        'The MSAP Alumni Association invites nominations for the annual Distinguished Alumni Excellence Awards. Categories include Young Achiever (Under 35), Architectural Excellence, Research Innovation, and Social Impact. Deadline for submissions is October 31, 2026.',
    publishDate: DateTime(2026, 10, 02),
    category: 'Awards',
    author: 'Executive Committee',
    isPinned: false,
  ),
  Announcement(
    id: 'anc_302',
    title: 'Launch of Alumni Endowment & Student Scholarship Fund',
    summary:
        'Help support deserving MSAP students through merit-cum-means financial aid and research grants.',
    content:
        'We are proud to announce the creation of the MSAP Alumni Endowment Fund. 100% of contributions will go directly toward supporting talented architecture and design students who require financial assistance.',
    publishDate: DateTime(2026, 09, 24),
    category: 'Scholarships',
    author: 'Treasurer MSAPAA',
    isPinned: false,
  ),
  Announcement(
    id: 'anc_303',
    title: 'New Campus Library Access Digital Pass Available',
    summary:
        'Alumni members in good standing can now request digital library credentials for online journals and archives.',
    content:
        'Through our updated partnership with MSAP Central Library, active alumni members gain remote digital access to JSTOR, Avery Index, and leading architectural research repositories. Claim your access code via the Profile section.',
    publishDate: DateTime(2026, 09, 15),
    category: 'Benefits',
    author: 'Library Advisory Board',
    isPinned: false,
  ),
];
