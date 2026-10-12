import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_avatar.dart';
import '../../../data/mock/mock_leadership.dart';
import '../../../models/leadership_member.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Separate leadership into distinct verified categories
    final officeBearers = mockLeadershipList
        .where((m) => m.category == LeadershipCategory.officeBearer)
        .toList();
    final president = officeBearers.isNotEmpty ? officeBearers.first : null;
    final otherOfficeBearers =
        officeBearers.length > 1 ? officeBearers.sublist(1) : <LeadershipMember>[];

    final executiveMembers = mockLeadershipList
        .where((m) => m.category == LeadershipCategory.executiveMember)
        .toList();

    final advisoryBoard = mockLeadershipList
        .where((m) => m.category == LeadershipCategory.advisoryBoard)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.creamBackground,
      appBar: AppBar(
        title: const Text(
          'Our Heritage & Governance',
          style: TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // SECTION A: About MSAP
            // ==========================================
            _buildSectionHeader(
              title: 'About MSAP',
              badge: 'Est. 1973',
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: AppColors.purpleAccent.withValues(alpha: 0.2),
                          ),
                        ),
                        child: const Icon(
                          Icons.account_balance_rounded,
                          color: AppColors.purpleAccent,
                          size: 26.0,
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppConstants.associationTitle,
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              AppConstants.tagLine,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: AppColors.border, height: 1.0),
                  ),
                  const Text(
                    'The Manipur Students\' Association Pune (MSAP) has stood as a beacon of solidarity, intellectual discourse, and mutual camaraderie since its inception in 1973. For over five decades, it has served as an enduring home-away-from-home for students and scholars from Manipur pursuing academic excellence in Pune.',
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.55,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'The MSAP Alumni Association unites thousands of accomplished graduates across architecture, public service, academia, literature, and entrepreneurship, nurturing an unbroken bridge between generations of members.',
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION B: Our Heritage (Timeline)
            // ==========================================
            _buildSectionHeader(
              title: 'Our Heritage',
              badge: '50+ Years of Legacy',
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
              decoration: _cardDecoration(),
              child: Column(
                children: [
                  _buildTimelineItem(
                    year: '1973',
                    title: 'Foundation of MSAP',
                    description:
                        'Established in Pune by pioneering students from Manipur to nurture solidarity, cultural connection, and educational support.',
                    isFirst: true,
                  ),
                  _buildTimelineItem(
                    year: '2023',
                    title: 'Golden Jubilee Celebration',
                    description:
                        'Marked 50 glorious years of community service, fellowship, and academic contribution across educational institutions in Pune and Maharashtra.',
                  ),
                  _buildTimelineItem(
                    year: '2024',
                    title: 'Alumni Working Group & Conclaves',
                    description:
                        'Strategic consultative sessions organized at Joysana Retreat (Oinam) and Hotel Castle (Imphal) to formalize the global alumni governance network.',
                  ),
                  _buildTimelineItem(
                    year: '2025 – Present',
                    title: '1st Grand Re-Union & Formal Incorporation',
                    description:
                        'Historic inaugural reunion at Manipur University Centenary Hall (May 11, 2025), officially ratifying executive governance and formal registration.',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION C: Office Bearers
            // ==========================================
            _buildSectionHeader(
              title: 'Office Bearers',
              badge: 'Executive Council',
            ),
            const SizedBox(height: 12.0),

            // President Featured Card
            if (president != null) ...[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: AppColors.purpleAccent.withValues(alpha: 0.35),
                    width: 1.4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purpleAccent.withValues(alpha: 0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.purpleAccent,
                          width: 2.0,
                        ),
                      ),
                      child: AppAvatar(
                        radius: 38.0,
                        imageUrl: president.imagePath,
                        fallbackText: president.name,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 3.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.purpleAccent,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: const Text(
                              'PRESIDENT',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            president.name,
                            style: const TextStyle(
                              fontFamily: 'serif',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          const Text(
                            'MSAP Alumni Association',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
            ],

            // Other Office Bearers List
            ...otherOfficeBearers.map((officer) => _buildOfficeBearerTile(officer)),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION D: Executive Members
            // ==========================================
            _buildSectionHeader(
              title: 'Executive Members',
              badge: '${executiveMembers.length} Members',
            ),
            const SizedBox(height: 12.0),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: executiveMembers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) {
                final member = executiveMembers[index];
                return _buildMemberGridCard(member);
              },
            ),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION E: Advisory Board
            // ==========================================
            _buildSectionHeader(
              title: 'Advisory Board',
              badge: 'Eminent Patrons & Legal Council',
            ),
            const SizedBox(height: 12.0),
            ...advisoryBoard.map((advisor) => _buildAdvisorCard(advisor)),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION F: Mission
            // ==========================================
            _buildSectionHeader(
              title: 'Our Mission',
              badge: 'Guiding Principles',
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColors.purpleLight,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(
                          Icons.flag_rounded,
                          color: AppColors.purpleAccent,
                          size: 20.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          'Commitment to Excellence & Community',
                          style: const TextStyle(
                            fontFamily: 'serif',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryDark,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'The MSAP Alumni Association is committed to creating an empowered, enduring network that fosters fellowship, mentorship for incoming students, cultural continuity, and socioeconomic contributions toward Manipur and the wider nation.',
                    style: TextStyle(
                      fontSize: 13.5,
                      height: 1.55,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28.0),

            // ==========================================
            // SECTION G: Registration Details
            // ==========================================
            _buildSectionHeader(
              title: 'Governance & Registration',
              badge: 'Official Entity',
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRegRow(
                    icon: Icons.verified_outlined,
                    label: 'Organization Name',
                    value: 'Manipur Students\' Association Pune (MSAP) Alumni',
                  ),
                  const Divider(height: 16.0, color: AppColors.border),
                  _buildRegRow(
                    icon: Icons.badge_outlined,
                    label: 'Status',
                    value: 'Registered Non-Profit Society / Alumni Body',
                  ),
                  const Divider(height: 16.0, color: AppColors.border),
                  _buildRegRow(
                    icon: Icons.place_outlined,
                    label: 'Registered Location',
                    value: 'Imphal, Manipur & Pune, Maharashtra, India',
                  ),
                  const Divider(height: 16.0, color: AppColors.border),
                  _buildRegRow(
                    icon: Icons.email_outlined,
                    label: 'Official Contact',
                    value: AppConstants.supportEmail,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Subtle Footer
            Center(
              child: Text(
                'MSAP Alumni Association • Version 1.0.0',
                style: TextStyle(
                  fontSize: 11.0,
                  color: AppColors.textMuted.withValues(alpha: 0.8),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  // Helper: Section title with subtle category badge
  Widget _buildSectionHeader({required String title, required String badge}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'serif',
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDark,
            letterSpacing: 0.2,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: AppColors.purpleLight,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: AppColors.purpleAccent.withValues(alpha: 0.2),
              width: 0.8,
            ),
          ),
          child: Text(
            badge,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.purpleAccent,
            ),
          ),
        ),
      ],
    );
  }

  // Helper: Card decoration matching website visual identity
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: AppColors.border, width: 0.9),
      boxShadow: const [
        BoxShadow(
          color: AppColors.cardShadow,
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  // Helper: Timeline Item
  Widget _buildTimelineItem({
    required String year,
    required String title,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year Indicator Column with Line
          SizedBox(
            width: 54.0,
            child: Text(
              year,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: AppColors.purpleAccent,
              ),
            ),
          ),
          // Vertical bullet & line
          Column(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: const BoxDecoration(
                  color: AppColors.purpleAccent,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12.0),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 4.0 : 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      height: 1.45,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Office Bearer tile
  Widget _buildOfficeBearerTile(LeadershipMember officer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.border, width: 0.8),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        leading: AppAvatar(
          radius: 24.0,
          imageUrl: officer.imagePath,
          fallbackText: officer.name,
        ),
        title: Text(
          officer.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.5,
            color: AppColors.primaryDark,
          ),
        ),
        subtitle: Text(
          officer.role,
          style: const TextStyle(
            fontSize: 11.5,
            color: AppColors.purpleAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Helper: Grid Card for Executive Members
  Widget _buildMemberGridCard(LeadershipMember member) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.border, width: 0.8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppAvatar(
            radius: 30.0,
            imageUrl: member.imagePath,
            fallbackText: member.name,
          ),
          const SizedBox(height: 8.0),
          Text(
            member.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: AppColors.primaryDark,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            member.role,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Advisor Card
  Widget _buildAdvisorCard(LeadershipMember advisor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.border,
          width: 0.9,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: AppAvatar(
              radius: 26.0,
              imageUrl: advisor.imagePath,
              fallbackText: advisor.name,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  advisor.name,
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 3.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    advisor.role,
                    style: const TextStyle(
                      fontSize: 10.5,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Registration Detail Row
  Widget _buildRegRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: AppColors.purpleAccent),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 1.0),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
