import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 02 BIO SCREEN — Design Style: Professional Corporate Profile
/// ============================================================================
/// Contributor: Member 02 (Chathupama Thathsarani)
/// Premium corporate profile adhering to an executive palette of navy blue,
/// crisp white, and refined gold. Employs NestedScrollView, SliverAppBar with
/// portrait header, TabBarView (About, Education, Skills), structured academic
/// records, linear progress indicators for soft skills, and bespoke cards for
/// special talents, enterprise experience, and engineering projects.
/// ============================================================================
class Member02Screen extends StatefulWidget {
  const Member02Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member02Screen> createState() => _Member02ScreenState();
}

class _Member02ScreenState extends State<Member02Screen> {
  // --- Professional Corporate Color Palette ---
  static const Color _navyDeep = Color(0xFF0A192F);
  static const Color _navyPrimary = Color(0xFF0F2942);
  static const Color _navyLight = Color(0xFF1E3A5F);
  static const Color _goldPrimary = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF3E5AB);
  static const Color _goldDark = Color(0xFFB8860B);
  static const Color _bgSurface = Color(0xFFF4F6F9);
  static const Color _cardBg = Colors.white;
  static const Color _textPrimary = Color(0xFF1E293B);
  static const Color _textMuted = Color(0xFF64748B);
  static const Color _borderColor = Color(0xFFE2E8F0);

  // Verified contact & background details from CV
  static const String _phone = '+94 77 136 7348';
  static const String _linkedIn = 'linkedin.com/in/chathupama-thathsarani-a49379360';
  static const String _gitHub = 'github.com/CTMJayasooriya';

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: _goldPrimary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Copied to clipboard: $email',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: _navyPrimary,
        behavior: SnackBarBehavior.floating,
        elevation: 6,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: _goldPrimary, width: 1.2),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: _bgSurface,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 295,
              pinned: true,
              elevation: innerBoxIsScrolled ? 4 : 0,
              backgroundColor: _navyPrimary,
              foregroundColor: Colors.white,
              title: AnimatedOpacity(
                opacity: innerBoxIsScrolled ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  m.fullName,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              actions: [
                FavoriteButton(
                  memberId: m.id,
                  activeColor: _goldPrimary,
                  inactiveColor: Colors.white,
                ),
                IconButton(
                  tooltip: 'Copy Email',
                  onPressed: () => _copyEmail(m.email),
                  icon: const Icon(Icons.email_outlined, color: Colors.white),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: _buildPortraitHeader(m),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: _navyDeep,
                  child: const TabBar(
                    indicatorColor: _goldPrimary,
                    indicatorWeight: 3.5,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: _goldLight,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      letterSpacing: 0.4,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.person_outline_rounded, size: 19),
                        text: 'About',
                      ),
                      Tab(
                        icon: Icon(Icons.school_outlined, size: 19),
                        text: 'Education',
                      ),
                      Tab(
                        icon: Icon(Icons.psychology_outlined, size: 19),
                        text: 'Skills',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildAboutTab(m),
              _buildEducationTab(m),
              _buildSkillsTab(m),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. PORTRAIT HEADER (Corporate Executive Styling)
  // ===========================================================================
  Widget _buildPortraitHeader(GroupMember m) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navyDeep, _navyPrimary, _navyLight],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 38, 20, 52),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Portrait with Gold Accent Ring
              Container(
                padding: const EdgeInsets.all(3.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _goldPrimary, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Hero(
                    tag: 'photo_${m.id}',
                    child: MemberPhoto(
                      assetPath: m.photoAsset,
                      memberNumber: m.memberNumber,
                      accentColor: _navyPrimary,
                      width: 92,
                      height: 92,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 18),

              // Executive Info & Badges
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: _goldPrimary.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _goldPrimary.withValues(alpha: 0.65),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_rounded, color: _goldPrimary, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'CORPORATE PROFILE • MEMBER 02',
                            style: TextStyle(
                              color: _goldLight,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      m.fullName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m.shortRole,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: _goldPrimary, size: 14),
                        const SizedBox(width: 3),
                        Text(
                          m.address,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. TAB 1: ABOUT (Summary, Identity & Contacts, Experience, References)
  // ===========================================================================
  Widget _buildAboutTab(GroupMember m) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // Executive Summary Card
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Executive Summary',
                icon: Icons.article_outlined,
              ),
              const SizedBox(height: 12),
              Text(
                m.shortDescription,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: _textPrimary,
                  height: 1.55,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 14),
              // Quoted Bio Philosophy
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _navyPrimary.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: const Border(
                    left: BorderSide(color: _goldPrimary, width: 4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.format_quote_rounded, color: _goldDark, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '"${m.bioQuote}"',
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: _navyPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Personal Contact & Identity Record Card
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: _SectionHeader(
                      title: 'Personal & Contact Information',
                      icon: Icons.contact_phone_outlined,
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: _navyPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    onPressed: () => _copyEmail(m.email),
                    icon: const Icon(Icons.copy_rounded, size: 14, color: _goldDark),
                    label: const Text(
                      'Copy Email',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  _corporateTableRow('Full Name', m.fullName, Icons.person_outline),
                  _corporateTableRow('Student ID', m.studentId, Icons.badge_outlined),
                  _corporateTableRow('Email', m.email, Icons.email_outlined, isLink: true, onTap: () => _copyEmail(m.email)),
                  _corporateTableRow('Phone', _phone, Icons.phone_outlined),
                  _corporateTableRow('Address', m.address, Icons.place_outlined),
                  _corporateTableRow('LinkedIn', _linkedIn, Icons.link_rounded),
                  _corporateTableRow('GitHub', _gitHub, Icons.code_rounded),
                  _corporateTableRow('Institution', 'ITUM, University of Moratuwa', Icons.school_outlined),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Professional Experience Card
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Professional Corporate Experience',
                icon: Icons.business_center_outlined,
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _bgSurface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _navyPrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.account_balance_outlined,
                            color: _goldLight,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Hatton National Bank (HNB)',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14.5,
                                  color: _navyPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Banking Intern • Colombo, Sri Lanka',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.5,
                                  color: _goldDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '2023 – 2024',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: _textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1, color: _borderColor),
                    const SizedBox(height: 10),
                    _experienceBullet(
                      'Assisted with day-to-day banking transactions and customer inquiries adhering to bank protocols.',
                    ),
                    const SizedBox(height: 6),
                    _experienceBullet(
                      'Leveraged digital banking software to maintain high data accuracy and rapid issue resolution.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Academic References Card
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Academic & Professional References',
                icon: Icons.people_outline_rounded,
              ),
              const SizedBox(height: 12),
              _buildReferenceTile(
                name: 'Mrs. A.U.P. Athukorala',
                role: 'Head of the Division',
                affiliation: 'Institute of Technology, University of Moratuwa (ITUM)',
                contact: 'uthpalap@itum.mrt.ac.lk • +94 77 266 6602',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: _borderColor),
              ),
              _buildReferenceTile(
                name: 'Mrs. D.A.S. Ruwanmini',
                role: 'Lecturer',
                affiliation: 'Institute of Technology, University of Moratuwa (ITUM)',
                contact: 'ruwanminis@itum.mrt.ac.lk • +94 77 855 8303',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ===========================================================================
  // 3. TAB 2: EDUCATION (Structured Qualifications & Certifications)
  // ===========================================================================
  Widget _buildEducationTab(GroupMember m) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // Education Summary Highlights
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_navyPrimary, _navyLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _navyPrimary.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metricKpiBox('${m.qualifications.length}', 'Qualifications'),
              Container(width: 1, height: 38, color: Colors.white24),
              _metricKpiBox('NDT', 'Undergraduate'),
              Container(width: 1, height: 38, color: Colors.white24),
              _metricKpiBox('2027', 'Expected'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Academic Qualifications in Structured Records
        ...List.generate(m.qualifications.length, (index) {
          final q = m.qualifications[index];
          final isPrimary = index == 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildCorporateCard(
              borderColor: isPrimary ? _goldPrimary : _borderColor,
              borderWidth: isPrimary ? 1.5 : 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Structured Index Pill
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: isPrimary ? _navyPrimary : _bgSurface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isPrimary ? _goldPrimary : _borderColor,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          (index + 1).toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: isPrimary ? _goldLight : _navyPrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Level Tag & Status Pill
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: _goldPrimary.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: _goldDark.withValues(alpha: 0.5),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Text(
                                    q.level.toUpperCase(),
                                    style: const TextStyle(
                                      color: _goldDark,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                if (q.gradeOrStatus != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                                    decoration: BoxDecoration(
                                      color: _navyPrimary.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      q.gradeOrStatus!,
                                      style: const TextStyle(
                                        color: _navyPrimary,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              q.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                                color: _navyPrimary,
                                height: 1.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: _borderColor),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.account_balance_outlined, size: 14, color: _textMuted),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          q.institution,
                          style: const TextStyle(
                            fontSize: 12,
                            color: _textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.calendar_today_outlined, size: 13, color: _goldDark),
                      const SizedBox(width: 4),
                      Text(
                        q.year,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _navyPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }

  // ===========================================================================
  // 4. TAB 3: SKILLS (Soft Skills w/ Progress, Talents Cards, Projects)
  // ===========================================================================
  Widget _buildSkillsTab(GroupMember m) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        // Soft Skills using Progress Indicators
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Professional Soft Skills',
                icon: Icons.psychology_outlined,
              ),
              const SizedBox(height: 16),
              ...m.softSkills.map((s) => _buildSoftSkillIndicator(s)),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Special Talents Displayed Using Professional Cards
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Special Talents & Professional Capabilities',
                icon: Icons.workspace_premium_outlined,
              ),
              const SizedBox(height: 14),
              ...m.talents.map((t) => _buildTalentCard(t)),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Software Engineering Projects
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Featured Engineering Projects',
                icon: Icons.terminal_rounded,
              ),
              const SizedBox(height: 14),
              _buildProjectTile(
                title: 'Serva',
                subtitle: 'University Infrastructure Maintenance & Monitoring Platform',
                techStack: 'React, Node.js, MySQL, REST APIs',
                description:
                    'Architected a centralized digital platform for the Premises Management Unit (ITUM) featuring real-time fault logging, ticket dispatching, and facility analytics.',
              ),
              const SizedBox(height: 10),
              _buildProjectTile(
                title: 'Online Election & Automated Voting System',
                subtitle: 'Audited Web-Based Electoral Platform',
                techStack: 'PHP, MySQL, JavaScript, HTML/CSS',
                description:
                    'Engineered secure voter registration, candidate administration, remote ballot submission, and automated result tabulation with verifiable audit trails.',
              ),
              const SizedBox(height: 10),
              _buildProjectTile(
                title: 'WedEase',
                subtitle: 'AI-Powered Wedding Planning Platform',
                techStack: 'React, Node.js, Express.js, MongoDB',
                description:
                    'Developing an AI-driven wedding platform with personalized vendor recommendations and centralized task management workflows.',
              ),
              const SizedBox(height: 10),
              _buildProjectTile(
                title: 'Dini-Mart',
                subtitle: 'Modern E-Commerce Web Application',
                techStack: 'React, JavaScript, HTML5, CSS3',
                description:
                    'Developed interactive catalog browsing, search/filtering, shopping cart quantity management, and total cost calculation.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Technical Stacks & Competencies Summary
        _buildCorporateCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _SectionHeader(
                title: 'Technical Stacks & Tooling',
                icon: Icons.integration_instructions_outlined,
              ),
              const SizedBox(height: 14),
              _buildTechCategory('Programming Languages', ['Java', 'Python', 'JavaScript', 'PHP']),
              const SizedBox(height: 8),
              _buildTechCategory('Mobile & Frontend', ['Flutter', 'React Native', 'React', 'HTML5', 'CSS3']),
              const SizedBox(height: 8),
              _buildTechCategory('Backend & Databases', ['Node.js', 'Express.js', 'MySQL', 'MongoDB', 'REST APIs']),
              const SizedBox(height: 8),
              _buildTechCategory('Tools & Methodologies', ['Git', 'GitHub', 'Docker', 'Android Studio', 'VS Code', 'Agile', 'OOP', 'MVC']),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ===========================================================================
  // 5. HELPER WIDGETS & CORPORATE COMPONENTS
  // ===========================================================================

  Widget _buildCorporateCard({
    required Widget child,
    Color borderColor = _borderColor,
    double borderWidth = 1.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildSoftSkillIndicator(SoftSkill skill) {
    final percentage = (skill.level * 100).round();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                  color: _navyPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: _navyPrimary.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    color: _goldDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: skill.level,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(_navyPrimary),
            ),
          ),
          if (skill.description.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              skill.description,
              style: const TextStyle(
                fontSize: 12,
                color: _textMuted,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTalentCard(SpecialTalent talent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _goldPrimary.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.star_rounded,
              color: _goldDark,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        talent.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13.5,
                          color: _navyPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _navyPrimary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        talent.category,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _navyLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  talent.detail,
                  style: const TextStyle(
                    fontSize: 12,
                    color: _textMuted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectTile({
    required String title,
    required String subtitle,
    required String techStack,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13.5,
                    color: _navyPrimary,
                  ),
                ),
              ),
              const Icon(Icons.arrow_outward_rounded, size: 15, color: _goldDark),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: _goldDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Stack: $techStack',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: _navyLight,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: _textMuted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechCategory(String category, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: _textMuted,
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 6,
          runSpacing: 5,
          children: items.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _navyPrimary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: _borderColor),
              ),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: _navyPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReferenceTile({
    required String name,
    required String role,
    required String affiliation,
    required String contact,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.5,
            color: _navyPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$role • $affiliation',
          style: const TextStyle(
            fontSize: 12,
            color: _textMuted,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          contact,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: _goldDark,
          ),
        ),
      ],
    );
  }

  TableRow _corporateTableRow(
    String label,
    String value,
    IconData icon, {
    bool isLink = false,
    VoidCallback? onTap,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: _goldDark),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: _textMuted,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: InkWell(
            onTap: onTap,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isLink ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12.5,
                color: isLink ? _navyPrimary : _textPrimary,
                decoration: isLink ? TextDecoration.underline : TextDecoration.none,
                decorationColor: _goldPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _metricKpiBox(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: _goldLight,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }

  Widget _experienceBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(Icons.circle, size: 6, color: _goldDark),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: _textPrimary,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

// Corporate Section Header component
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Icon(icon, size: 17, color: const Color(0xFF0F2942)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F2942),
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}
