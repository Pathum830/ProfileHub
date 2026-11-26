import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 05 BIO SCREEN — Design Style: Personal Journey Timeline
/// ============================================================================
/// Contributor: Member 05 (Chamodi Madhushani)
/// Elegant green, cream, and dark charcoal biography screen featuring a
/// custom-clipped curved portrait header with CustomPainter contour arcs,
/// quick chapter navigation with smooth scrolling, interactive vertical
/// academic timeline nodes with AnimatedCrossFade, separate skill milestone
/// cards, and a dark-charcoal talents & hobbies showcase.
/// ============================================================================
class Member05Screen extends StatefulWidget {
  const Member05Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member05Screen> createState() => _Member05ScreenState();
}

class _Member05ScreenState extends State<Member05Screen>
    with SingleTickerProviderStateMixin {
  // Elegant Green, Cream & Dark Charcoal Palette
  static const Color _cream = Color(0xFFF6F2E7);
  static const Color _cardCream = Color(0xFFFFFDF8);
  static const Color _sageTint = Color(0xFFE7EFEA);
  static const Color _borderWarm = Color(0xFFDFD8C8);
  static const Color _forestGreen = Color(0xFF1B4D3E);
  static const Color _emeraldGreen = Color(0xFF2D6A4F);
  static const Color _goldAccent = Color(0xFF9E7B3B);
  static const Color _charcoal = Color(0xFF1C2320);
  static const Color _charcoalMuted = Color(0xFF4A5650);

  late final ScrollController _scrollController;
  late final AnimationController _introController;

  final GlobalKey _introKey = GlobalKey();
  final GlobalKey _timelineKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _talentsKey = GlobalKey();

  int _selectedMilestone = 0;
  bool _expandAllMilestones = false;
  int? _selectedSkillIndex;
  int _activeChapterIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();

    final count = widget.member.qualifications.length;
    if (count > 0) {
      _selectedMilestone = count - 1;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _introController.dispose();
    super.dispose();
  }

  Future<void> _scrollToChapter(int index, GlobalKey key) async {
    setState(() => _activeChapterIndex = index);
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeOutCubic,
      alignment: 0.06,
    );
  }

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied email: $email'),
        backgroundColor: _charcoal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 390;
    final horizontalPadding = screenWidth >= 640
        ? 28.0
        : isCompact
            ? 14.0
            : 18.0;

    return Scaffold(
      backgroundColor: _cream,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: _buildCurvedHeroHeader(context, m, isCompact),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 780),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      8,
                      horizontalPadding,
                      40,
                    ),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _introController,
                        curve: Curves.easeOut,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildChapterNavigator(),
                          const SizedBox(height: 20),
                          KeyedSubtree(
                            key: _introKey,
                            child: _buildPersonalIntroduction(m),
                          ),
                          const SizedBox(height: 28),
                          KeyedSubtree(
                            key: _timelineKey,
                            child: _buildAcademicTimelineSection(m),
                          ),
                          const SizedBox(height: 28),
                          KeyedSubtree(
                            key: _skillsKey,
                            child: _buildSkillMilestoneSection(m),
                          ),
                          const SizedBox(height: 28),
                          KeyedSubtree(
                            key: _talentsKey,
                            child: _buildTalentsAndHobbiesSection(m),
                          ),
                        ],
                      ),
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

  Widget _buildCurvedHeroHeader(
    BuildContext context,
    GroupMember m,
    bool isCompact,
  ) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return ClipPath(
      clipper: _JourneyHeaderClipper(),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_charcoal, _forestGreen, _emeraldGreen],
            stops: [0.0, 0.55, 1.0],
          ),
        ),
        child: CustomPaint(
          painter: _JourneyContourPainter(),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              isCompact ? 14 : 20,
              topPadding + 8,
              isCompact ? 14 : 20,
              52,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Material(
                          color: _cream.withValues(alpha: 0.12),
                          shape: const CircleBorder(),
                          child: BackButton(
                            color: _cream,
                            onPressed: () => Navigator.of(context).maybePop(),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _cream.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: _cream.withValues(alpha: 0.24),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.route_rounded,
                                  size: 15,
                                  color: Color(0xFFD8E8DF),
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    'Member 05 • ${m.designStyleName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: _cream,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        FavoriteButton(
                          memberId: m.id,
                          activeColor: const Color(0xFFF3C669),
                          inactiveColor: _cream,
                          backgroundColor: _cream.withValues(alpha: 0.12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final stacked = constraints.maxWidth < 340;
                        final avatar = _buildPortraitFrame(m, isCompact);

                        final identity = Column(
                          crossAxisAlignment: stacked
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _goldAccent.withValues(alpha: 0.26),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFD6B472)
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              child: Text(
                                m.studentId,
                                style: const TextStyle(
                                  color: Color(0xFFF5E6C4),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              m.fullName,
                              textAlign: stacked
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: TextStyle(
                                color: _cream,
                                fontSize: isCompact ? 22 : 26,
                                fontWeight: FontWeight.w800,
                                height: 1.15,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              m.shortRole,
                              textAlign: stacked
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: TextStyle(
                                color: _cream.withValues(alpha: 0.88),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );

                        if (stacked) {
                          return Column(
                            children: [
                              avatar,
                              const SizedBox(height: 14),
                              identity,
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            avatar,
                            SizedBox(width: isCompact ? 14 : 20),
                            Expanded(child: identity),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitFrame(GroupMember m, bool isCompact) {
    final size = isCompact ? 92.0 : 108.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [_cream, Color(0xFF9AC5AF)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.30),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Hero(
            tag: 'photo_${m.id}',
            child: ClipOval(
              child: MemberPhoto(
                assetPath: m.photoAsset,
                memberNumber: m.memberNumber,
                accentColor: _forestGreen,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: -2,
          bottom: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _charcoal,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _cream, width: 1.5),
            ),
            child: const Text(
              '05',
              style: TextStyle(
                color: _cream,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChapterNavigator() {
    final chapters = [
      (label: 'Introduction', icon: Icons.person_outline_rounded, key: _introKey),
      (label: 'Academics', icon: Icons.timeline_rounded, key: _timelineKey),
      (label: 'Skills', icon: Icons.workspace_premium_outlined, key: _skillsKey),
      (label: 'Talents', icon: Icons.auto_awesome_outlined, key: _talentsKey),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(chapters.length, (index) {
          final chapter = chapters[index];
          final active = _activeChapterIndex == index;

          return Padding(
            padding: EdgeInsets.only(right: index < chapters.length - 1 ? 8 : 0),
            child: InkWell(
              onTap: () => _scrollToChapter(index, chapter.key),
              borderRadius: BorderRadius.circular(24),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: active ? _forestGreen : _cardCream,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: active ? _forestGreen : _borderWarm,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      chapter.icon,
                      size: 16,
                      color: active ? _cream : _forestGreen,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      chapter.label,
                      style: TextStyle(
                        color: active ? _cream : _charcoal,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPersonalIntroduction(GroupMember m) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _cardCream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderWarm),
        boxShadow: [
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _sageTint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 18,
                  color: _forestGreen,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHAPTER 01',
                      style: TextStyle(
                        color: _goldAccent,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Personal Introduction',
                      style: TextStyle(
                        color: _charcoal,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            m.shortDescription,
            style: const TextStyle(
              color: _charcoal,
              fontSize: 14.5,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: BoxDecoration(
              color: _sageTint.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                left: BorderSide(color: _forestGreen, width: 3.5),
              ),
            ),
            child: Text(
              '"${m.bioQuote}"',
              style: const TextStyle(
                color: _forestGreen,
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: _borderWarm),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              _ContactChip(
                icon: Icons.location_on_outlined,
                label: m.address,
                iconColor: _forestGreen,
              ),
              _ContactChip(
                icon: Icons.mail_outline_rounded,
                label: m.email,
                iconColor: _goldAccent,
                trailingIcon: Icons.copy_rounded,
                onTap: () => _copyEmail(m.email),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicTimelineSection(GroupMember m) {
    final qualifications = m.qualifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHAPTER 02',
                    style: TextStyle(
                      color: _goldAccent,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Academic Journey Timeline',
                    style: TextStyle(
                      color: _charcoal,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Tap any timeline node to inspect institutional details',
                    style: TextStyle(
                      color: _charcoalMuted,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() => _expandAllMilestones = !_expandAllMilestones);
              },
              style: TextButton.styleFrom(
                foregroundColor: _forestGreen,
                backgroundColor: _sageTint,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: Icon(
                _expandAllMilestones
                    ? Icons.unfold_less_rounded
                    : Icons.unfold_more_rounded,
                size: 16,
              ),
              label: Text(
                _expandAllMilestones ? 'Focus' : 'Expand All',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Column(
          children: List.generate(qualifications.length, (index) {
            final q = qualifications[index];
            final isFirst = index == 0;
            final isLast = index == qualifications.length - 1;
            final isSelected = _selectedMilestone == index;
            final isExpanded = _expandAllMilestones || isSelected;
            final isOngoing =
                (q.gradeOrStatus ?? '').toLowerCase().contains('ongoing') ||
                    q.year.toLowerCase().contains('present');

            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 44,
                    child: CustomPaint(
                      painter: _TimelineSpinePainter(
                        isFirst: isFirst,
                        isLast: isLast,
                        isActive: isSelected,
                        isOngoing: isOngoing,
                        lineColor: _forestGreen.withValues(alpha: 0.30),
                        activeColor: _forestGreen,
                        highlightColor: _goldAccent,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _expandAllMilestones = false;
                                    _selectedMilestone = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 240),
                                  width: isSelected ? 32 : 26,
                                  height: isSelected ? 32 : 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        isSelected ? _forestGreen : _cardCream,
                                    border: Border.all(
                                      color: isSelected
                                          ? _goldAccent
                                          : _forestGreen,
                                      width: isSelected ? 2.5 : 2,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: _forestGreen
                                                  .withValues(alpha: 0.25),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Icon(
                                    _iconForLevel(q.level),
                                    size: isSelected ? 15 : 13,
                                    color: isSelected ? _cream : _forestGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _expandAllMilestones = false;
                            _selectedMilestone = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 240),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isSelected ? _cardCream : const Color(0xFFFAF7EE),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? _forestGreen : _borderWarm,
                              width: isSelected ? 1.6 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: _forestGreen.withValues(alpha: 0.08),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isOngoing
                                          ? _forestGreen
                                          : _sageTint,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      q.level,
                                      style: TextStyle(
                                        color: isOngoing ? _cream : _forestGreen,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      q.year,
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        color: _goldAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                q.title,
                                style: const TextStyle(
                                  color: _charcoal,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  height: 1.3,
                                ),
                              ),
                              AnimatedCrossFade(
                                duration: const Duration(milliseconds: 250),
                                sizeCurve: Curves.easeOutCubic,
                                crossFadeState: isExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    'Tap to view institution & status',
                                    style: TextStyle(
                                      color:
                                          _charcoalMuted.withValues(alpha: 0.8),
                                      fontSize: 11.5,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                secondChild: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: _sageTint.withValues(alpha: 0.55),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.account_balance_outlined,
                                              size: 15,
                                              color: _forestGreen,
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                q.institution,
                                                style: const TextStyle(
                                                  color: _charcoal,
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (q.gradeOrStatus != null &&
                                            q.gradeOrStatus!.isNotEmpty) ...[
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.verified_outlined,
                                                size: 15,
                                                color: _goldAccent,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  'Status: ${q.gradeOrStatus}',
                                                  style: const TextStyle(
                                                    color: _charcoalMuted,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSkillMilestoneSection(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CHAPTER 03',
          style: TextStyle(
            color: _goldAccent,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Skill Milestones',
          style: TextStyle(
            color: _charcoal,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'Core soft skills forged along the learning journey',
          style: TextStyle(
            color: _charcoalMuted,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 560;
            const spacing = 12.0;
            final cardWidth = twoColumns
                ? (constraints.maxWidth - spacing) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: List.generate(m.softSkills.length, (index) {
                final skill = m.softSkills[index];
                final selected = _selectedSkillIndex == index;

                return SizedBox(
                  width: cardWidth,
                  child: _SkillMilestoneCard(
                    index: index,
                    skill: skill,
                    isSelected: selected,
                    onTap: () {
                      setState(() {
                        _selectedSkillIndex = selected ? null : index;
                      });
                    },
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTalentsAndHobbiesSection(GroupMember m) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _charcoal,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _charcoal.withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: _forestGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: Color(0xFFDCEBE2),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHAPTER 04',
                      style: TextStyle(
                        color: Color(0xFFD6B472),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Special Talents & Hobbies',
                      style: TextStyle(
                        color: _cream,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(m.talents.length, (index) {
            final talent = m.talents[index];
            final isLast = index == m.talents.length - 1;

            return Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF26302B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _cream.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: _emeraldGreen.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _iconForTalent(talent.category),
                      size: 19,
                      color: const Color(0xFFB7DEC9),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                talent.title,
                                style: const TextStyle(
                                  color: _cream,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _goldAccent.withValues(alpha: 0.24),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                talent.category,
                                style: const TextStyle(
                                  color: Color(0xFFF3D59B),
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          talent.detail,
                          style: TextStyle(
                            color: _cream.withValues(alpha: 0.78),
                            fontSize: 12.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _iconForLevel(String level) {
    final normalized = level.toLowerCase();
    if (normalized.contains('o/l') || normalized.contains('a/l')) {
      return Icons.menu_book_rounded;
    }
    if (normalized.contains('certificate')) {
      return Icons.workspace_premium_rounded;
    }
    if (normalized.contains('diploma')) {
      return Icons.school_outlined;
    }
    return Icons.school_rounded;
  }

  IconData _iconForTalent(String category) {
    final normalized = category.toLowerCase();
    if (normalized.contains('sport')) return Icons.sports_cricket_outlined;
    if (normalized.contains('music')) return Icons.music_note_rounded;
    if (normalized.contains('art')) return Icons.palette_outlined;
    if (normalized.contains('tech')) return Icons.code_rounded;
    return Icons.star_outline_rounded;
  }
}

class _ContactChip extends StatelessWidget {
  const _ContactChip({
    required this.icon,
    required this.label,
    required this.iconColor,
    this.trailingIcon,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F2E7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDFD8C8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: iconColor),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1C2320),
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 6),
            Icon(
              trailingIcon,
              size: 14,
              color: const Color(0xFF4A5650),
            ),
          ],
        ],
      ),
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: content,
    );
  }
}

class _SkillMilestoneCard extends StatelessWidget {
  const _SkillMilestoneCard({
    required this.index,
    required this.skill,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final SoftSkill skill;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const cardCream = Color(0xFFFFFDF8);
    const forestGreen = Color(0xFF1B4D3E);
    const sageTint = Color(0xFFE7EFEA);
    const goldAccent = Color(0xFF9E7B3B);
    const charcoal = Color(0xFF1C2320);
    const charcoalMuted = Color(0xFF4A5650);
    const borderWarm = Color(0xFFDFD8C8);

    final badgeNumber = (index + 1).toString().padLeft(2, '0');
    final levelPercent = (skill.level.clamp(0.0, 1.0) * 100).round();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: cardCream,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? forestGreen : borderWarm,
            width: isSelected ? 1.6 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: charcoal.withValues(alpha: isSelected ? 0.08 : 0.03),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? forestGreen : charcoal,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'MILESTONE $badgeNumber',
                    style: const TextStyle(
                      color: Color(0xFFF6F2E7),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '$levelPercent%',
                  style: const TextStyle(
                    color: goldAccent,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              skill.name,
              style: const TextStyle(
                color: charcoal,
                fontSize: 15.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: skill.level.clamp(0.0, 1.0),
                minHeight: 6,
                backgroundColor: sageTint,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isSelected ? goldAccent : forestGreen,
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 220),
              crossFadeState: isSelected || skill.description.isNotEmpty
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Text(
                  skill.description,
                  maxLines: isSelected ? 5 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: charcoalMuted,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JourneyHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height - 34);
    path.quadraticBezierTo(
      size.width * 0.28,
      size.height + 6,
      size.width * 0.56,
      size.height - 22,
    );
    path.quadraticBezierTo(
      size.width * 0.82,
      size.height - 48,
      size.width,
      size.height - 14,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _JourneyContourPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFF6F2E7).withValues(alpha: 0.10);

    for (var i = 0; i < 4; i++) {
      final radius = 90.0 + (i * 48.0);
      canvas.drawCircle(
        Offset(size.width * 0.92, size.height * 0.16),
        radius,
        arcPaint,
      );
    }

    final routePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = const Color(0xFFD6B472).withValues(alpha: 0.22);

    final routePath = Path()
      ..moveTo(-20, size.height * 0.78)
      ..cubicTo(
        size.width * 0.22,
        size.height * 0.56,
        size.width * 0.48,
        size.height * 0.92,
        size.width * 0.85,
        size.height * 0.60,
      );
    canvas.drawPath(routePath, routePaint);

    final dotPaint = Paint()
      ..color = const Color(0xFFF6F2E7).withValues(alpha: 0.18);
    for (var i = 1; i <= 5; i++) {
      final angle = i * 0.55;
      final dx = size.width * 0.12 + math.cos(angle) * 28 * i;
      final dy = size.height * 0.18 + math.sin(angle) * 14;
      canvas.drawCircle(Offset(dx, dy), 2.2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TimelineSpinePainter extends CustomPainter {
  _TimelineSpinePainter({
    required this.isFirst,
    required this.isLast,
    required this.isActive,
    required this.isOngoing,
    required this.lineColor,
    required this.activeColor,
    required this.highlightColor,
  });

  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final bool isOngoing;
  final Color lineColor;
  final Color activeColor;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    // Matches top padding (14) + half of 32x32 node container (16)
    const nodeY = 30.0;

    final paint = Paint()
      ..color = isActive ? activeColor.withValues(alpha: 0.55) : lineColor
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    if (!isFirst) {
      canvas.drawLine(
        Offset(centerX, 0),
        Offset(centerX, nodeY - 14),
        paint,
      );
    }

    if (!isLast) {
      final startY = nodeY + 14;
      if (isOngoing) {
        // Dashed continuation for ongoing stage
        const dash = 5.0;
        const gap = 4.0;
        var y = startY;
        while (y < size.height) {
          final endY = math.min(y + dash, size.height);
          canvas.drawLine(
            Offset(centerX, y),
            Offset(centerX, endY),
            paint,
          );
          y += dash + gap;
        }
      } else {
        canvas.drawLine(
          Offset(centerX, startY),
          Offset(centerX, size.height),
          paint,
        );
      }
    }

    if (isActive) {
      final haloPaint = Paint()
        ..color = highlightColor.withValues(alpha: 0.24)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX, nodeY), 20, haloPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TimelineSpinePainter oldDelegate) {
    return oldDelegate.isFirst != isFirst ||
        oldDelegate.isLast != isLast ||
        oldDelegate.isActive != isActive ||
        oldDelegate.isOngoing != isOngoing;
  }
}
