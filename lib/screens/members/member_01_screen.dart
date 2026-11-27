import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 01 PORTFOLIO SCREEN — Pathum Siriwardhana
/// ============================================================================
/// Design Style: Executive DevOps & Software Engineering Portfolio
/// Palette: Deep Navy (#101B35), Royal Blue (#315EBD), White (#FFFFFF),
///          Light Grey (#F4F6FA).
/// Sections:
///   - Hero Header with verified portrait, name, professional identity & nav
///   - About Me & Contact Details
///   - Education Timeline
///   - Technical Skills (grouped by category, no invented ratings)
///   - Featured Projects (GuideLanka, PartTime LK, ERP Module, CI/CD Pipeline)
///   - Work Experience (Training Assistant – People's Bank, undated)
///   - Certifications (IBM SkillsBuild, University of Moratuwa, Google)
///   - Professional Contact Footer
/// ============================================================================
class Member01Screen extends StatefulWidget {
  const Member01Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member01Screen> createState() => _Member01ScreenState();
}

class _Member01ScreenState extends State<Member01Screen>
    with SingleTickerProviderStateMixin {
  // Core Palette
  static const Color _deepNavy = Color(0xFF101B35);
  static const Color _navyElevated = Color(0xFF17264A);
  static const Color _royalBlue = Color(0xFF315EBD);
  static const Color _royalBlueSoft = Color(0xFFEAF0FC);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightGrey = Color(0xFFF4F6FA);
  static const Color _borderGrey = Color(0xFFE1E6F0);
  static const Color _slateText = Color(0xFF475569);
  static const Color _mutedNavy = Color(0xFF94A3B8);

  late final ScrollController _scrollController;
  late final AnimationController _entranceController;
  bool _showAppBarTitle = false;
  String _selectedSkillCategory = 'All';

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  static const List<String> _summaryParagraphs = [
    'Information Technology student at the Institute of Technology, University of Moratuwa (ITUM), with academic project experience in software development, backend engineering, RESTful API development, database management, cloud technologies and DevOps automation.',
    'Hands-on experience with Python, Java, Go, JavaScript, Dart, Flutter, Docker, Git, GitHub Actions, Linux and CI/CD workflows.',
    'Interested in building reliable software applications, backend systems and automated deployment pipelines.',
  ];

  static const List<_SkillCategory> _skillCategories = [
    _SkillCategory(
      id: 'Languages',
      title: 'Programming Languages',
      icon: Icons.code_rounded,
      skills: [
        'Python',
        'Java',
        'Go',
        'JavaScript',
        'Dart',
        'PHP',
        'SQL',
        'Bash',
      ],
    ),
    _SkillCategory(
      id: 'Backend',
      title: 'Backend Frameworks',
      icon: Icons.dns_rounded,
      skills: [
        'FastAPI',
        'Spring Boot',
        'Gin (Go)',
        'Node.js',
        'Express.js',
        'Laravel',
      ],
    ),
    _SkillCategory(
      id: 'Frontend',
      title: 'Frontend & Mobile',
      icon: Icons.devices_rounded,
      skills: [
        'Vue.js',
        'React',
        'Flutter',
      ],
    ),
    _SkillCategory(
      id: 'DevOps',
      title: 'DevOps & Tools',
      icon: Icons.settings_suggest_rounded,
      skills: [
        'Docker',
        'Git',
        'GitHub',
        'GitHub Actions',
        'Maven',
        'Linux',
        'CI/CD',
        'Bash Scripting',
      ],
    ),
    _SkillCategory(
      id: 'Databases',
      title: 'Databases',
      icon: Icons.storage_rounded,
      skills: [
        'PostgreSQL',
        'MySQL',
        'MongoDB',
      ],
    ),
    _SkillCategory(
      id: 'Cloud',
      title: 'Cloud & Backend Services',
      icon: Icons.cloud_queue_rounded,
      skills: [
        'Supabase',
        'Firebase',
        'Vercel',
      ],
    ),
  ];

  static const List<_PortfolioProject> _featuredProjects = [
    _PortfolioProject(
      number: '01',
      title: 'GuideLanka',
      subtitle: 'AI-Powered Rural Tourism and Safari Management Platform',
      icon: Icons.explore_rounded,
      technologies: [
        'Python',
        'FastAPI',
        'PostgreSQL',
        'Supabase',
        'Gemini API',
      ],
      highlights: [
        'Developed backend services for GPS tracking and emergency monitoring.',
        'Integrated Gemini API.',
        'Worked with Supabase and PostgreSQL.',
      ],
    ),
    _PortfolioProject(
      number: '02',
      title: 'PartTime LK',
      subtitle: 'Part-Time Job Marketplace',
      icon: Icons.work_outline_rounded,
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'Git',
        'GitHub',
      ],
      highlights: [
        'Developed a mobile application connecting part-time job seekers with employers.',
        'Integrated Firebase services.',
        'Used Git and GitHub for version control.',
      ],
    ),
    _PortfolioProject(
      number: '03',
      title: 'ERP Project Management Module',
      subtitle: 'Enterprise Project Workflow & Backend System',
      icon: Icons.hub_rounded,
      technologies: [
        'Go',
        'Gin',
        'GORM',
        'PostgreSQL',
        'Docker',
        'JWT',
        'Vue.js 3',
      ],
      highlights: [
        'Developed backend APIs.',
        'Worked with database management and JWT authentication.',
        'Used Docker for development environment consistency.',
        'Collaborated using Git and GitHub.',
      ],
    ),
    _PortfolioProject(
      number: '04',
      title: 'CI/CD Pipeline Implementation',
      subtitle: 'Automated Build, Test & Delivery Workflow',
      icon: Icons.account_tree_rounded,
      technologies: [
        'Java',
        'Spring Boot',
        'Maven',
        'GitHub Actions',
      ],
      highlights: [
        'Implemented CI/CD workflows.',
        'Automated Maven build and testing processes.',
        'Managed source code using Git and GitHub.',
      ],
    ),
  ];

  static const List<_CertificationItem> _certifications = [
    _CertificationItem(
      title: 'Cloud Computing Fundamentals',
      issuer: 'IBM SkillsBuild',
      year: '2026',
      icon: Icons.cloud_done_outlined,
    ),
    _CertificationItem(
      title: 'Python for Beginners',
      issuer: 'University of Moratuwa',
      year: '2025',
      icon: Icons.terminal_rounded,
    ),
    _CertificationItem(
      title: 'Google AI Essentials',
      issuer: 'Google',
      year: '2026',
      icon: Icons.auto_awesome_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..forward();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final shouldShow = _scrollController.offset > 170;
    if (shouldShow != _showAppBarTitle) {
      setState(() => _showAppBarTitle = shouldShow);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: _white,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text('Email copied: $email')),
          ],
        ),
        backgroundColor: _deepNavy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 400;
    final horizontalPadding = screenWidth >= 900
        ? 36.0
        : screenWidth >= 600
            ? 24.0
            : isCompact
                ? 14.0
                : 18.0;

    return Scaffold(
      backgroundColor: _lightGrey,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          _buildPinnedAppBar(m),
          SliverToBoxAdapter(
            child: _buildHeroSection(m, screenWidth, isCompact),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      24,
                      horizontalPadding,
                      40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.05,
                          end: 0.45,
                          child: KeyedSubtree(
                            key: _aboutKey,
                            child: _buildAboutAndContactSection(m, isCompact),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.15,
                          end: 0.55,
                          child: KeyedSubtree(
                            key: _educationKey,
                            child: _buildEducationTimelineSection(m),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.25,
                          end: 0.68,
                          child: KeyedSubtree(
                            key: _skillsKey,
                            child: _buildTechnicalSkillsSection(),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.35,
                          end: 0.78,
                          child: KeyedSubtree(
                            key: _projectsKey,
                            child: _buildFeaturedProjectsSection(),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.45,
                          end: 0.90,
                          child: _buildExperienceAndCertificationsRow(),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredBlock(
                          controller: _entranceController,
                          start: 0.55,
                          end: 1.0,
                          child: KeyedSubtree(
                            key: _contactKey,
                            child: _buildProfessionalContactFooter(m),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedAppBar(GroupMember m) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: _deepNavy,
      foregroundColor: _white,
      titleSpacing: 4,
      title: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: _showAppBarTitle ? 1.0 : 0.0,
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: _royalBlue,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                m.fullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Copy email',
          onPressed: () => _copyEmail(m.email),
          icon: const Icon(Icons.mail_outline_rounded, size: 20),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FavoriteButton(
            memberId: m.id,
            activeColor: const Color(0xFF60A5FA),
            inactiveColor: _white,
            backgroundColor: _navyElevated,
            iconSize: 20,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2.5),
        child: _PortfolioScrollProgress(controller: _scrollController),
      ),
    );
  }

  Widget _buildHeroSection(
    GroupMember m,
    double screenWidth,
    bool isCompact,
  ) {
    final isWide = screenWidth >= 680;
    final horizontalPad = screenWidth >= 900
        ? 36.0
        : isWide
            ? 24.0
            : isCompact
                ? 16.0
                : 20.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_deepNavy, Color(0xFF142244)],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _BlueprintGridPainter(),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPad,
                  12,
                  horizontalPad,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isWide)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _HeroPortraitFrame(
                            member: m,
                            size: 146,
                          ),
                          const SizedBox(width: 28),
                          Expanded(
                            child: _buildHeroIdentityBlock(m, isCentered: false),
                          ),
                        ],
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: _HeroPortraitFrame(
                              member: m,
                              size: isCompact ? 118 : 132,
                            ),
                          ),
                          const SizedBox(height: 18),
                          _buildHeroIdentityBlock(m, isCentered: true),
                        ],
                      ),
                    const SizedBox(height: 22),
                    _buildQuickJumpNav(isCentered: !isWide),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroIdentityBlock(GroupMember m, {required bool isCentered}) {
    final align = isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isCentered ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: _royalBlue.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _royalBlue.withValues(alpha: 0.65),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 13,
                color: Color(0xFF93C5FD),
              ),
              SizedBox(width: 6),
              Flexible(
                child: Text(
                  'MEMBER 01  •  IT PORTFOLIO',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFFDBEAFE),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          m.fullName,
          textAlign: textAlign,
          style: TextStyle(
            color: _white,
            fontSize: isCentered ? 26 : 32,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          m.shortRole,
          textAlign: textAlign,
          style: const TextStyle(
            color: Color(0xFF93C5FD),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 8,
          children: [
            _HeroMetaPill(
              icon: Icons.location_on_outlined,
              label: m.address,
            ),
            _HeroMetaPill(
              icon: Icons.school_outlined,
              label: 'ITUM • 2024 – Present',
            ),
            InkWell(
              onTap: () => _copyEmail(m.email),
              borderRadius: BorderRadius.circular(20),
              child: _HeroMetaPill(
                icon: Icons.mail_outline_rounded,
                label: m.email,
                isInteractive: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickJumpNav({required bool isCentered}) {
    final navItems = [
      ('About', Icons.person_outline_rounded, _aboutKey),
      ('Education', Icons.school_outlined, _educationKey),
      ('Skills', Icons.layers_outlined, _skillsKey),
      ('Projects', Icons.rocket_launch_outlined, _projectsKey),
      ('Experience', Icons.work_outline_rounded, _experienceKey),
      ('Certifications', Icons.workspace_premium_outlined, _certificationsKey),
      ('Contact', Icons.alternate_email_rounded, _contactKey),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: _navyElevated.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _royalBlue.withValues(alpha: 0.3),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment:
              isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: navItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: InkWell(
                onTap: () => _scrollToSection(item.$3),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: _deepNavy.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.$2,
                        size: 14,
                        color: const Color(0xFF93C5FD),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.$1,
                        style: const TextStyle(
                          color: _white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAboutAndContactSection(GroupMember m, bool isCompact) {
    return _PortfolioCard(
      padding: EdgeInsets.all(isCompact ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '01 / PROFILE',
            title: 'About Me & Contact Details',
            subtitle: 'Professional summary and verified contact information',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 660;
              final aboutText = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < _summaryParagraphs.length; i++) ...[
                    if (i < _summaryParagraphs.length - 1)
                      Text(
                        _summaryParagraphs[i],
                        style: const TextStyle(
                          color: _deepNavy,
                          fontSize: 14.5,
                          height: 1.65,
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _royalBlueSoft.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(12),
                          border: const Border(
                            left: BorderSide(color: _royalBlue, width: 3.5),
                          ),
                        ),
                        child: Text(
                          _summaryParagraphs[i],
                          style: const TextStyle(
                            color: _deepNavy,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.55,
                          ),
                        ),
                      ),
                    if (i < _summaryParagraphs.length - 1)
                      const SizedBox(height: 12),
                  ],
                ],
              );

              final contactDetails = Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _lightGrey,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _borderGrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DIRECT DETAILS',
                      style: TextStyle(
                        color: _royalBlue,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _DetailInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Full Name',
                      value: m.fullName,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: _borderGrey, height: 1),
                    ),
                    _DetailInfoRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: m.address,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: _borderGrey, height: 1),
                    ),
                    _DetailInfoRow(
                      icon: Icons.mail_outline_rounded,
                      label: 'Email',
                      value: m.email,
                      trailing: IconButton(
                        tooltip: 'Copy email address',
                        onPressed: () => _copyEmail(m.email),
                        icon: const Icon(
                          Icons.copy_rounded,
                          size: 18,
                          color: _royalBlue,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(color: _borderGrey, height: 1),
                    ),
                    const _DetailInfoRow(
                      icon: Icons.engineering_outlined,
                      label: 'Focus',
                      value: 'Software Engineering • DevOps & Cloud',
                    ),
                  ],
                ),
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: aboutText),
                    const SizedBox(width: 22),
                    Expanded(flex: 5, child: contactDetails),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  aboutText,
                  const SizedBox(height: 18),
                  contactDetails,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducationTimelineSection(GroupMember m) {
    final educationEntries = m.qualifications
        .where((q) => q.level.toLowerCase() != 'certificate')
        .toList();

    return _PortfolioCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '02 / EDUCATION',
            title: 'Education Timeline',
            subtitle: 'Academic foundation in Information Technology',
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < educationEntries.length; i++)
            _EducationTimelineItem(
              qualification: educationEntries[i],
              isFirst: i == 0,
              isLast: i == educationEntries.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _buildTechnicalSkillsSection() {
    final visibleCategories = _selectedSkillCategory == 'All'
        ? _skillCategories
        : _skillCategories
            .where((c) => c.id == _selectedSkillCategory)
            .toList();

    return _PortfolioCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '03 / CAPABILITIES',
            title: 'Technical Skills',
            subtitle: 'Languages, frameworks, DevOps tools, databases & cloud',
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildSkillFilterChip('All', 'All Categories'),
                for (final category in _skillCategories)
                  _buildSkillFilterChip(category.id, category.id),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AnimatedSize(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 600 &&
                        visibleCategories.length > 1
                    ? 2
                    : 1;
                const spacing = 14.0;
                final cardWidth = columns == 1
                    ? constraints.maxWidth
                    : (constraints.maxWidth - spacing) / 2;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: visibleCategories
                      .map(
                        (category) => SizedBox(
                          width: cardWidth,
                          child: _SkillCategoryCard(category: category),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillFilterChip(String id, String label) {
    final selected = _selectedSkillCategory == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        selectedColor: _deepNavy,
        backgroundColor: _lightGrey,
        side: BorderSide(
          color: selected ? _deepNavy : _borderGrey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        labelStyle: TextStyle(
          color: selected ? _white : _slateText,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) => setState(() => _selectedSkillCategory = id),
      ),
    );
  }

  Widget _buildFeaturedProjectsSection() {
    return _PortfolioCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '04 / ENGINEERING WORK',
            title: 'Featured Projects',
            subtitle: 'Backend services, mobile applications, and CI/CD pipelines',
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoColumns = constraints.maxWidth >= 640;
              const spacing = 16.0;
              final itemWidth = twoColumns
                  ? (constraints.maxWidth - spacing) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: _featuredProjects
                    .map(
                      (project) => SizedBox(
                        width: itemWidth,
                        child: _FeaturedProjectCard(project: project),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceAndCertificationsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sideBySide = constraints.maxWidth >= 680;
        final experienceWidget = KeyedSubtree(
          key: _experienceKey,
          child: _buildWorkExperienceCard(),
        );
        final certificationsWidget = KeyedSubtree(
          key: _certificationsKey,
          child: _buildCertificationsCard(),
        );

        if (sideBySide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: experienceWidget),
              const SizedBox(width: 18),
              Expanded(flex: 7, child: certificationsWidget),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            experienceWidget,
            const SizedBox(height: 22),
            certificationsWidget,
          ],
        );
      },
    );
  }

  Widget _buildWorkExperienceCard() {
    return _PortfolioCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '05 / EXPERIENCE',
            title: 'Work Experience',
            subtitle: 'Industry & organizational background',
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _lightGrey,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _borderGrey),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _deepNavy,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.account_balance_outlined,
                    color: _white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Training Assistant',
                        style: TextStyle(
                          color: _deepNavy,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "People's Bank",
                        style: TextStyle(
                          color: _royalBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationsCard() {
    return _PortfolioCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PortfolioSectionTitle(
            eyebrow: '06 / CREDENTIALS',
            title: 'Certifications',
            subtitle: 'Verified technical & cloud coursework',
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < _certifications.length; i++) ...[
            _CertificationTile(item: _certifications[i]),
            if (i < _certifications.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildProfessionalContactFooter(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_deepNavy, Color(0xFF17284E)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _deepNavy.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 560;
          final textBlock = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _royalBlue.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _royalBlue.withValues(alpha: 0.6),
                  ),
                ),
                child: const Text(
                  '07 / CONNECT',
                  style: TextStyle(
                    color: Color(0xFFDBEAFE),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Get in Touch',
                style: TextStyle(
                  color: _white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Available for software engineering, backend development, and DevOps & cloud opportunities.',
                style: TextStyle(
                  color: _white.withValues(alpha: 0.84),
                  fontSize: 13.5,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 14,
                runSpacing: 8,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Color(0xFF93C5FD),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          m.address,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        size: 15,
                        color: Color(0xFF93C5FD),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          m.email,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );

          final actions = Column(
            crossAxisAlignment:
                isWide ? CrossAxisAlignment.end : CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledButton.icon(
                onPressed: () => _copyEmail(m.email),
                style: FilledButton.styleFrom(
                  backgroundColor: _royalBlue,
                  foregroundColor: _white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.copy_rounded, size: 18),
                label: const Text(
                  'Copy Email',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutCubic,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: _white,
                  side: BorderSide(
                    color: _white.withValues(alpha: 0.28),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: const Icon(Icons.arrow_upward_rounded, size: 17),
                label: const Text(
                  'Back to Top',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: textBlock),
                const SizedBox(width: 24),
                actions,
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textBlock,
              const SizedBox(height: 18),
              actions,
            ],
          );
        },
      ),
    );
  }
}

class _HeroPortraitFrame extends StatelessWidget {
  const _HeroPortraitFrame({
    required this.member,
    required this.size,
  });

  final GroupMember member;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _Member01ScreenState._royalBlue,
            Color(0xFF60A5FA),
            _Member01ScreenState._royalBlue,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: _Member01ScreenState._royalBlue.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: _Member01ScreenState._deepNavy,
          borderRadius: BorderRadius.circular(22),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Hero(
            tag: 'photo_${member.id}',
            child: MemberPhoto(
              assetPath: member.photoAsset,
              memberNumber: member.memberNumber,
              accentColor: _Member01ScreenState._royalBlue,
              width: size - 14,
              height: size - 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroMetaPill extends StatelessWidget {
  const _HeroMetaPill({
    required this.icon,
    required this.label,
    this.isInteractive = false,
  });

  final IconData icon;
  final String label;
  final bool isInteractive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: isInteractive
            ? _Member01ScreenState._royalBlue.withValues(alpha: 0.26)
            : _Member01ScreenState._navyElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isInteractive
              ? _Member01ScreenState._royalBlue
              : _Member01ScreenState._white.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF93C5FD),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _Member01ScreenState._white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (isInteractive) ...[
            const SizedBox(width: 6),
            const Icon(
              Icons.copy_rounded,
              size: 12,
              color: Color(0xFFBFDBFE),
            ),
          ],
        ],
      ),
    );
  }
}

class _PortfolioCard extends StatelessWidget {
  const _PortfolioCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _Member01ScreenState._white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _Member01ScreenState._borderGrey),
        boxShadow: [
          BoxShadow(
            color: _Member01ScreenState._deepNavy.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _PortfolioSectionTitle extends StatelessWidget {
  const _PortfolioSectionTitle({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });

  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 18,
              height: 2.5,
              decoration: BoxDecoration(
                color: _Member01ScreenState._royalBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                eyebrow,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _Member01ScreenState._royalBlue,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: _Member01ScreenState._deepNavy,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          style: const TextStyle(
            color: _Member01ScreenState._slateText,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class _DetailInfoRow extends StatelessWidget {
  const _DetailInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _Member01ScreenState._royalBlueSoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 18,
            color: _Member01ScreenState._royalBlue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  color: _Member01ScreenState._mutedNavy,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: _Member01ScreenState._deepNavy,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

class _EducationTimelineItem extends StatelessWidget {
  const _EducationTimelineItem({
    required this.qualification,
    required this.isFirst,
    required this.isLast,
  });

  final AcademicQualification qualification;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: 8,
                  color: isFirst
                      ? Colors.transparent
                      : _Member01ScreenState._borderGrey,
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _Member01ScreenState._royalBlue,
                    border: Border.all(
                      color: _Member01ScreenState._royalBlueSoft,
                      width: 3,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast
                        ? Colors.transparent
                        : _Member01ScreenState._borderGrey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _Member01ScreenState._lightGrey,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _Member01ScreenState._borderGrey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _Member01ScreenState._royalBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            qualification.year,
                            style: const TextStyle(
                              color: _Member01ScreenState._white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: _Member01ScreenState._white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _Member01ScreenState._borderGrey,
                            ),
                          ),
                          child: Text(
                            qualification.level,
                            style: const TextStyle(
                              color: _Member01ScreenState._deepNavy,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      qualification.title,
                      style: const TextStyle(
                        color: _Member01ScreenState._deepNavy,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.account_balance_rounded,
                            size: 14,
                            color: _Member01ScreenState._royalBlue,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            qualification.institution,
                            style: const TextStyle(
                              color: _Member01ScreenState._slateText,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category});

  final _SkillCategory category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _Member01ScreenState._lightGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Member01ScreenState._borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: _Member01ScreenState._deepNavy,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category.icon,
                  size: 18,
                  color: _Member01ScreenState._white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  category.title,
                  style: const TextStyle(
                    color: _Member01ScreenState._deepNavy,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: category.skills
                .map(
                  (skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _Member01ScreenState._white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _Member01ScreenState._borderGrey,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: const TextStyle(
                        color: _Member01ScreenState._deepNavy,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  const _FeaturedProjectCard({required this.project});

  final _PortfolioProject project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _Member01ScreenState._lightGrey,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _Member01ScreenState._borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _Member01ScreenState._royalBlueSoft,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _Member01ScreenState._royalBlue.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(
                  project.icon,
                  size: 20,
                  color: _Member01ScreenState._royalBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PROJECT ${project.number}',
                      style: const TextStyle(
                        color: _Member01ScreenState._royalBlue,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      project.title,
                      style: const TextStyle(
                        color: _Member01ScreenState._deepNavy,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            project.subtitle,
            style: const TextStyle(
              color: _Member01ScreenState._slateText,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies
                .map(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _Member01ScreenState._deepNavy,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: _Member01ScreenState._white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 14),
          const Divider(color: _Member01ScreenState._borderGrey, height: 1),
          const SizedBox(height: 12),
          for (var i = 0; i < project.highlights.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Icon(
                    Icons.circle,
                    size: 6,
                    color: _Member01ScreenState._royalBlue,
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    project.highlights[i],
                    style: const TextStyle(
                      color: _Member01ScreenState._deepNavy,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
            if (i < project.highlights.length - 1) const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _CertificationTile extends StatelessWidget {
  const _CertificationTile({required this.item});

  final _CertificationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _Member01ScreenState._lightGrey,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Member01ScreenState._borderGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _Member01ScreenState._royalBlueSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              size: 20,
              color: _Member01ScreenState._royalBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: _Member01ScreenState._deepNavy,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.issuer,
                  style: const TextStyle(
                    color: _Member01ScreenState._slateText,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _Member01ScreenState._white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _Member01ScreenState._borderGrey),
            ),
            child: Text(
              item.year,
              style: const TextStyle(
                color: _Member01ScreenState._royalBlue,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioScrollProgress extends StatelessWidget {
  const _PortfolioScrollProgress({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        var progress = 0.0;
        if (controller.hasClients && controller.position.hasContentDimensions) {
          final maxExtent = controller.position.maxScrollExtent;
          if (maxExtent > 0) {
            progress = (controller.offset / maxExtent).clamp(0.0, 1.0);
          }
        }
        return LinearProgressIndicator(
          value: progress,
          minHeight: 2.5,
          backgroundColor: _Member01ScreenState._navyElevated,
          valueColor: const AlwaysStoppedAnimation<Color>(
            _Member01ScreenState._royalBlue,
          ),
        );
      },
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = _Member01ScreenState._royalBlue.withValues(alpha: 0.11)
      ..strokeWidth = 1;

    const step = 36.0;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          _Member01ScreenState._royalBlue.withValues(alpha: 0.22),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * 0.85, size.height * 0.2),
          radius: 190,
        ),
      );
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.2),
      190,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StaggeredBlock extends StatelessWidget {
  const _StaggeredBlock({
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
  });

  final AnimationController controller;
  final double start;
  final double end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}

class _SkillCategory {
  const _SkillCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.skills,
  });

  final String id;
  final String title;
  final IconData icon;
  final List<String> skills;
}

class _PortfolioProject {
  const _PortfolioProject({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.technologies,
    required this.highlights,
  });

  final String number;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> technologies;
  final List<String> highlights;
}

class _CertificationItem {
  const _CertificationItem({
    required this.title,
    required this.issuer,
    required this.year,
    required this.icon,
  });

  final String title;
  final String issuer;
  final String year;
  final IconData icon;
}
