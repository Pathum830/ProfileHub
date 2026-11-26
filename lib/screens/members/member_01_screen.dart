import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 01 BIO SCREEN — Design Style: Modern Minimalist Profile
/// ============================================================================
/// Contributor: Member 01 (Pathum Siriwardhana)
/// Modern minimalist white & beige biography layout featuring a collapsible
/// SliverAppBar with a circular framed portrait, smooth scroll-driven
/// animations, structured Cards, an academic timeline, minimalist soft skill
/// indicators, and a responsive talents & hobbies showcase.
/// ============================================================================
class Member01Screen extends StatefulWidget {
  const Member01Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member01Screen> createState() => _Member01ScreenState();
}

class _Member01ScreenState extends State<Member01Screen>
    with SingleTickerProviderStateMixin {
  // Elegant White & Beige Minimalist Palette
  static const Color _alabaster = Color(0xFFFBF9F5);
  static const Color _pureWhite = Color(0xFFFFFFFF);
  static const Color _linenBeige = Color(0xFFF4EFE6);
  static const Color _sandBeige = Color(0xFFE7DEC9);
  static const Color _stoneBorder = Color(0xFFE5DDD0);
  static const Color _espresso = Color(0xFF1F1B17);
  static const Color _umber = Color(0xFF6B6257);
  static const Color _bronze = Color(0xFF9C7A54);

  late final ScrollController _scrollController;
  late final AnimationController _entranceController;
  String _activeFilter = 'All';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied email: $email'),
        backgroundColor: _espresso,
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
    final horizontalPadding = screenWidth >= 640
        ? 28.0
        : isCompact
            ? 16.0
            : 20.0;

    return Scaffold(
      backgroundColor: _alabaster,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          _buildSliverAppBar(m, isCompact),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      20,
                      horizontalPadding,
                      40,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _StaggeredEntrance(
                          controller: _entranceController,
                          start: 0.0,
                          end: 0.45,
                          child: _buildSummaryCard(m, isCompact),
                        ),
                        const SizedBox(height: 16),
                        _StaggeredEntrance(
                          controller: _entranceController,
                          start: 0.12,
                          end: 0.58,
                          child: _buildContactCard(m),
                        ),
                        const SizedBox(height: 22),
                        _StaggeredEntrance(
                          controller: _entranceController,
                          start: 0.22,
                          end: 0.70,
                          child: _buildFilterBar(),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (_activeFilter == 'All' ||
                                  _activeFilter == 'Academics') ...[
                                _StaggeredEntrance(
                                  controller: _entranceController,
                                  start: 0.30,
                                  end: 0.80,
                                  child: _buildAcademicsTimelineCard(m),
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (_activeFilter == 'All' ||
                                  _activeFilter == 'Skills') ...[
                                _StaggeredEntrance(
                                  controller: _entranceController,
                                  start: 0.40,
                                  end: 0.90,
                                  child: _buildSoftSkillsCard(m),
                                ),
                                const SizedBox(height: 16),
                              ],
                              if (_activeFilter == 'All' ||
                                  _activeFilter == 'Talents')
                                _StaggeredEntrance(
                                  controller: _entranceController,
                                  start: 0.50,
                                  end: 1.0,
                                  child: _buildTalentsCard(m),
                                ),
                            ],
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

  Widget _buildSliverAppBar(GroupMember m, bool isCompact) {
    final expandedHeight = isCompact ? 336.0 : 348.0;

    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: expandedHeight,
      backgroundColor: _alabaster,
      surfaceTintColor: Colors.transparent,
      foregroundColor: _espresso,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FavoriteButton(
            memberId: m.id,
            activeColor: _bronze,
            inactiveColor: _espresso,
            backgroundColor: _pureWhite.withValues(alpha: 0.88),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: _ScrollProgressBar(
          controller: _scrollController,
          trackColor: _stoneBorder.withValues(alpha: 0.55),
          fillColor: _bronze,
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = MediaQuery.paddingOf(context).top;
          final minHeight = kToolbarHeight + topPadding + 2;
          final maxHeight = expandedHeight + topPadding;
          final collapseRatio = ((maxHeight - constraints.biggest.height) /
                  (maxHeight - minHeight))
              .clamp(0.0, 1.0);
          final heroOpacity = (1.0 - collapseRatio * 1.45).clamp(0.0, 1.0);
          final titleOpacity = ((collapseRatio - 0.58) / 0.42).clamp(0.0, 1.0);

          return Stack(
            fit: StackFit.expand,
            children: [
              // Subtle alabaster-to-linen gradient backdrop
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_pureWhite, _alabaster, _linenBeige],
                  ),
                ),
              ),
              // Minimalist decorative hairline rings
              Positioned(
                top: -40,
                right: -50,
                child: Opacity(
                  opacity: heroOpacity * 0.45,
                  child: Container(
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: _sandBeige, width: 1.2),
                    ),
                  ),
                ),
              ),
              // Expanded Circular Portrait & Full Name Header
              Positioned.fill(
                child: ClipRect(
                  child: Opacity(
                    opacity: heroOpacity,
                    child: Transform.translate(
                      offset: Offset(0, -18 * collapseRatio),
                      child: SafeArea(
                        bottom: false,
                        child: OverflowBox(
                          minHeight: 0,
                          maxHeight: expandedHeight,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 44, 24, 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _FramedCircularPhoto(
                                  member: m,
                                  size: isCompact ? 114 : 128,
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _pureWhite,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: _stoneBorder),
                                  ),
                                  child: Text(
                                    'MEMBER 01  •  ${m.designStyleName.toUpperCase()}',
                                    style: const TextStyle(
                                      color: _bronze,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.6,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 9),
                                Text(
                                  m.fullName,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _espresso,
                                    fontSize: isCompact ? 23 : 26,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.6,
                                    height: 1.15,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  m.shortRole.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: _umber,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Collapsed AppBar Title
              Positioned(
                left: 56,
                right: 64,
                bottom: 16,
                child: IgnorePointer(
                  ignoring: titleOpacity < 0.1,
                  child: Opacity(
                    opacity: titleOpacity,
                    child: Text(
                      m.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _espresso,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(GroupMember m, bool isCompact) {
    return _MinimalistCard(
      padding: EdgeInsets.all(isCompact ? 18 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            indexLabel: '00',
            title: 'PROFILE OVERVIEW',
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _linenBeige,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                m.studentId,
                style: const TextStyle(
                  color: _umber,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            m.shortDescription,
            style: const TextStyle(
              color: _espresso,
              fontSize: 14.5,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: _linenBeige.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                left: BorderSide(color: _bronze, width: 3),
              ),
            ),
            child: Text(
              '"${m.bioQuote}"',
              style: const TextStyle(
                color: _umber,
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(GroupMember m) {
    return _MinimalistCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            indexLabel: '01',
            title: 'CONTACT & LOCATION',
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoColumns = constraints.maxWidth >= 500;
              final addressTile = _ContactTile(
                icon: Icons.place_outlined,
                label: 'ADDRESS',
                value: m.address,
              );
              final emailTile = _ContactTile(
                icon: Icons.mail_outline_rounded,
                label: 'EMAIL',
                value: m.email,
                trailing: IconButton(
                  tooltip: 'Copy email address',
                  onPressed: () => _copyEmail(m.email),
                  icon: const Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: _bronze,
                  ),
                ),
              );

              if (twoColumns) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: addressTile),
                    Container(
                      width: 1,
                      height: 46,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: _stoneBorder,
                    ),
                    Expanded(child: emailTile),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addressTile,
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: _stoneBorder, height: 1),
                  ),
                  emailTile,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    const filters = [
      ('All', 'All Sections'),
      ('Academics', 'Academics'),
      ('Skills', 'Soft Skills'),
      ('Talents', 'Talents'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((item) {
          final key = item.$1;
          final label = item.$2;
          final selected = _activeFilter == key;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: selected,
              showCheckmark: false,
              selectedColor: _espresso,
              backgroundColor: _pureWhite,
              side: BorderSide(
                color: selected ? _espresso : _stoneBorder,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              labelStyle: TextStyle(
                color: selected ? _alabaster : _umber,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
              onSelected: (_) => setState(() => _activeFilter = key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAcademicsTimelineCard(GroupMember m) {
    final qualifications = m.qualifications;

    return _MinimalistCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            indexLabel: '02',
            title: 'ACADEMIC TIMELINE',
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < qualifications.length; i++)
            _TimelineEntry(
              qualification: qualifications[i],
              isFirst: i == 0,
              isLast: i == qualifications.length - 1,
              isHighlighted: i == qualifications.length - 1,
            ),
        ],
      ),
    );
  }

  Widget _buildSoftSkillsCard(GroupMember m) {
    return _MinimalistCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            indexLabel: '03',
            title: 'SOFT SKILLS',
          ),
          const SizedBox(height: 18),
          for (var i = 0; i < m.softSkills.length; i++) ...[
            _MinimalistSkillRow(skill: m.softSkills[i]),
            if (i < m.softSkills.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(color: _stoneBorder, height: 1),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildTalentsCard(GroupMember m) {
    return _MinimalistCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeader(
            indexLabel: '04',
            title: 'SPECIAL TALENTS & HOBBIES',
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 520 ? 2 : 1;
              const spacing = 12.0;
              final itemWidth = columns == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - spacing) / 2;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: m.talents
                    .map(
                      (talent) => SizedBox(
                        width: itemWidth,
                        child: _TalentTile(talent: talent),
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
}

class _FramedCircularPhoto extends StatelessWidget {
  const _FramedCircularPhoto({
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
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _Member01ScreenState._pureWhite,
        border: Border.all(
          color: _Member01ScreenState._sandBeige,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _Member01ScreenState._bronze.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: Hero(
          tag: 'photo_${member.id}',
          child: MemberPhoto(
            assetPath: member.photoAsset,
            memberNumber: member.memberNumber,
            accentColor: _Member01ScreenState._bronze,
            width: size - 10,
            height: size - 10,
          ),
        ),
      ),
    );
  }
}

class _MinimalistCard extends StatelessWidget {
  const _MinimalistCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: _Member01ScreenState._pureWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: _Member01ScreenState._stoneBorder),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.indexLabel,
    required this.title,
  });

  final String indexLabel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: _Member01ScreenState._linenBeige,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            indexLabel,
            style: const TextStyle(
              color: _Member01ScreenState._bronze,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _Member01ScreenState._espresso,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.8,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
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
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: _Member01ScreenState._linenBeige,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: _Member01ScreenState._bronze,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _Member01ScreenState._umber,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: _Member01ScreenState._espresso,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
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

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.qualification,
    required this.isFirst,
    required this.isLast,
    required this.isHighlighted,
  });

  final AcademicQualification qualification;
  final bool isFirst;
  final bool isLast;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final isPlaceholder =
        qualification.title.toLowerCase().contains('placeholder') ||
            qualification.institution.toLowerCase().contains('placeholder');

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 1.5,
                  height: 6,
                  color: isFirst
                      ? Colors.transparent
                      : _Member01ScreenState._stoneBorder,
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHighlighted
                        ? _Member01ScreenState._bronze
                        : _Member01ScreenState._pureWhite,
                    border: Border.all(
                      color: isPlaceholder
                          ? _Member01ScreenState._sandBeige
                          : _Member01ScreenState._bronze,
                      width: 2,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: isLast
                        ? Colors.transparent
                        : _Member01ScreenState._stoneBorder,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? _Member01ScreenState._linenBeige
                      : _Member01ScreenState._alabaster,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isHighlighted
                        ? _Member01ScreenState._sandBeige
                        : _Member01ScreenState._stoneBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          qualification.year,
                          style: const TextStyle(
                            color: _Member01ScreenState._bronze,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _Member01ScreenState._pureWhite,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _Member01ScreenState._stoneBorder,
                            ),
                          ),
                          child: Text(
                            qualification.level,
                            style: const TextStyle(
                              color: _Member01ScreenState._umber,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (qualification.gradeOrStatus != null)
                          Text(
                            '• ${qualification.gradeOrStatus!}',
                            style: const TextStyle(
                              color: _Member01ScreenState._umber,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      qualification.title,
                      style: const TextStyle(
                        color: _Member01ScreenState._espresso,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      qualification.institution,
                      style: const TextStyle(
                        color: _Member01ScreenState._umber,
                        fontSize: 12.5,
                        height: 1.35,
                      ),
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

class _MinimalistSkillRow extends StatelessWidget {
  const _MinimalistSkillRow({required this.skill});

  final SoftSkill skill;

  @override
  Widget build(BuildContext context) {
    final segments = 5;
    final filledSegments = (skill.level * segments).round().clamp(1, segments);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                skill.name,
                style: const TextStyle(
                  color: _Member01ScreenState._espresso,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Minimalist 5-dot indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(segments, (index) {
                final active = index < filledSegments;
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.only(left: index == 0 ? 0 : 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active
                        ? _Member01ScreenState._bronze
                        : _Member01ScreenState._sandBeige.withValues(alpha: 0.7),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: skill.level.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 4,
                backgroundColor: _Member01ScreenState._linenBeige,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  _Member01ScreenState._bronze,
                ),
              ),
            );
          },
        ),
        if (skill.description.isNotEmpty) ...[
          const SizedBox(height: 7),
          Text(
            skill.description,
            style: const TextStyle(
              color: _Member01ScreenState._umber,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ],
    );
  }
}

class _TalentTile extends StatelessWidget {
  const _TalentTile({required this.talent});

  final SpecialTalent talent;

  IconData _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'art':
        return Icons.palette_outlined;
      case 'sports':
        return Icons.directions_run_rounded;
      case 'music':
        return Icons.music_note_outlined;
      case 'tech hobby':
        return Icons.terminal_rounded;
      default:
        return Icons.auto_awesome_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _Member01ScreenState._alabaster,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _Member01ScreenState._stoneBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: _Member01ScreenState._linenBeige,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _iconForCategory(talent.category),
                  size: 16,
                  color: _Member01ScreenState._bronze,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  talent.category.toUpperCase(),
                  style: const TextStyle(
                    color: _Member01ScreenState._bronze,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            talent.title,
            style: const TextStyle(
              color: _Member01ScreenState._espresso,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            talent.detail,
            style: const TextStyle(
              color: _Member01ScreenState._umber,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollProgressBar extends StatelessWidget {
  const _ScrollProgressBar({
    required this.controller,
    required this.trackColor,
    required this.fillColor,
  });

  final ScrollController controller;
  final Color trackColor;
  final Color fillColor;

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
          minHeight: 2,
          backgroundColor: trackColor,
          valueColor: AlwaysStoppedAnimation<Color>(fillColor),
        );
      },
    );
  }
}

class _StaggeredEntrance extends StatelessWidget {
  const _StaggeredEntrance({
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
          begin: const Offset(0, 0.04),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}
