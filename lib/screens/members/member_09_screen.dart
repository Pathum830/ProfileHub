import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 09 BIO SCREEN — Design Style: Modern Personal Analytics Dashboard
/// ============================================================================
/// Contributor: Namadee Umedya (Member 09)
/// Professional teal, white, and dark navy personal analytics dashboard featuring:
/// - Dark navy dashboard profile header with photograph and personal metadata
/// - Interactive accent colour selection with animated color transitions
/// - KPI-style tiles in a responsive GridView
/// - CustomPaint segmented circular soft-skills chart with interactive selection
/// - Structured DataTable for academic qualifications with category filtering
/// - Responsive GridView dashboard cards for talents & hobbies
/// ============================================================================
class Member09Screen extends StatefulWidget {
  const Member09Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member09Screen> createState() => _Member09ScreenState();
}

class _AccentPreset {
  const _AccentPreset({
    required this.label,
    required this.primary,
    required this.secondary,
  });

  final String label;
  final Color primary;
  final Color secondary;
}

enum _AcademicFilter { all, education, certificates }

class _Member09ScreenState extends State<Member09Screen>
    with SingleTickerProviderStateMixin {
  static const Color _navy = Color(0xFF0B192C);
  static const Color _navySurface = Color(0xFF132946);
  static const Color _canvas = Color(0xFFF3F7FA);
  static const Color _cardWhite = Color(0xFFFFFFFF);
  static const Color _border = Color(0xFFDCE6F1);
  static const Color _ink = Color(0xFF0F1E33);
  static const Color _muted = Color(0xFF5A6B82);

  static const List<_AccentPreset> _accentPresets = [
    _AccentPreset(
      label: 'Teal',
      primary: Color(0xFF0D9488),
      secondary: Color(0xFF14B8A6),
    ),
    _AccentPreset(
      label: 'Ocean',
      primary: Color(0xFF0284C7),
      secondary: Color(0xFF38BDF8),
    ),
    _AccentPreset(
      label: 'Emerald',
      primary: Color(0xFF059669),
      secondary: Color(0xFF34D399),
    ),
    _AccentPreset(
      label: 'Navy Blue',
      primary: Color(0xFF1D4ED8),
      secondary: Color(0xFF60A5FA),
    ),
  ];

  late final AnimationController _entranceController;
  int _accentIdx = 0;
  int _selectedSkillIdx = 0;
  _AcademicFilter _academicFilter = _AcademicFilter.all;
  bool _compactTable = false;

  _AccentPreset get _preset => _accentPresets[_accentIdx];
  Color get _accent => _preset.primary;
  Color get _accentLight => _preset.secondary;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  List<Color> _segmentColorsForPalette() {
    return [
      _accent,
      _accentLight,
      const Color(0xFF1E3A8A),
      const Color(0xFF0F766E),
      const Color(0xFF38BDF8),
      const Color(0xFF334155),
    ];
  }

  Future<void> _copyText(String label, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: _navy,
      ),
    );
  }

  Widget _animatedSection(int index, Widget child) {
    final start = (index * 0.1).clamp(0.0, 0.5);
    final end = (start + 0.5).clamp(0.0, 1.0);
    final anim = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.04),
          end: Offset.zero,
        ).animate(anim),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final avgSkill = m.softSkills.isEmpty
        ? 0.0
        : m.softSkills.map((s) => s.level).reduce((a, b) => a + b) /
            m.softSkills.length;

    return Scaffold(
      backgroundColor: _canvas,
      appBar: AppBar(
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _accentLight.withValues(alpha: 0.45),
                ),
              ),
              child: Icon(
                Icons.analytics_rounded,
                color: _accentLight,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Flexible(
              child: Text(
                'Personal Analytics',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Cycle accent color',
            onPressed: () {
              setState(
                () => _accentIdx = (_accentIdx + 1) % _accentPresets.length,
              );
            },
            icon: Icon(Icons.palette_outlined, color: _accentLight),
          ),
          FavoriteButton(
            memberId: m.id,
            activeColor: _accentLight,
            inactiveColor: Colors.white70,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _animatedSection(0, _buildDashboardHeader(m)),
                const SizedBox(height: 14),
                _animatedSection(1, _buildKpiGrid(m, avgSkill)),
                const SizedBox(height: 14),
                _animatedSection(2, _buildPersonalInfoPanel(m)),
                const SizedBox(height: 14),
                _animatedSection(3, _buildSoftSkillsAnalytics(m, avgSkill)),
                const SizedBox(height: 14),
                _animatedSection(4, _buildAcademicsDataTable(m)),
                const SizedBox(height: 14),
                _animatedSection(5, _buildTalentsGrid(m)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardHeader(GroupMember m) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, _navySurface],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _accent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;
              final profileBlock = Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [_accentLight, _accent],
                      ),
                    ),
                    child: Hero(
                      tag: 'photo_${m.id}',
                      child: MemberPhoto(
                        assetPath: m.photoAsset,
                        memberNumber: m.memberNumber,
                        accentColor: _accent,
                        width: isWide ? 96 : 80,
                        height: isWide ? 96 : 80,
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _headerBadge(
                              'MEMBER ${m.memberNumber.toString().padLeft(2, '0')}',
                              _accent,
                            ),
                            _headerBadge(
                              m.designStyleName,
                              Colors.white.withValues(alpha: 0.14),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          m.fullName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          m.shortRole,
                          style: TextStyle(
                            color: _accentLight,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          m.shortDescription,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.82),
                            fontSize: 12.8,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final quickMeta = Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerMetaRow(
                      icon: Icons.badge_outlined,
                      label: 'ID',
                      value: m.studentId,
                    ),
                    const SizedBox(height: 8),
                    _headerMetaRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: m.address,
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _copyText('Email', m.email),
                      borderRadius: BorderRadius.circular(8),
                      child: _headerMetaRow(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: m.email,
                        trailingIcon: Icons.copy_rounded,
                      ),
                    ),
                  ],
                ),
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: profileBlock),
                    const SizedBox(width: 18),
                    Expanded(flex: 4, child: quickMeta),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  profileBlock,
                  const SizedBox(height: 14),
                  quickMeta,
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tune_rounded, size: 16, color: _accentLight),
                    const SizedBox(width: 8),
                    Text(
                      'Dashboard Accent: ${_preset.label}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: List.generate(_accentPresets.length, (i) {
                    final preset = _accentPresets[i];
                    final selected = i == _accentIdx;
                    return InkWell(
                      onTap: () => setState(() => _accentIdx = i),
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? preset.primary.withValues(alpha: 0.28)
                              : Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selected
                                ? preset.secondary
                                : Colors.white.withValues(alpha: 0.16),
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 11,
                              height: 11,
                              decoration: BoxDecoration(
                                color: preset.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              preset.label,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.78),
                                fontSize: 11.5,
                                fontWeight: selected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerBadge(String text, Color bg, {Color textColor = Colors.white}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _headerMetaRow({
    required IconData icon,
    required String label,
    required String value,
    IconData? trailingIcon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 15, color: _accentLight),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.60),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (trailingIcon != null)
          Icon(
            trailingIcon,
            size: 14,
            color: Colors.white.withValues(alpha: 0.65),
          ),
      ],
    );
  }

  Widget _buildKpiGrid(GroupMember m, double avgSkill) {
    final certsCount = m.qualifications
        .where((q) => q.level.toLowerCase().contains('cert'))
        .length;
    final kpis = [
      (
        'Qualifications',
        '${m.qualifications.length}',
        '$certsCount certifications logged',
        Icons.school_rounded,
      ),
      (
        'Soft Skills',
        '${m.softSkills.length}',
        'Core interpersonal traits',
        Icons.psychology_rounded,
      ),
      (
        'Talents & Hobbies',
        '${m.talents.length}',
        'Creative & technical focus',
        Icons.auto_awesome_rounded,
      ),
      (
        'Skill Index',
        '${(avgSkill * 100).round()}%',
        'Placeholder indicator avg',
        Icons.insights_rounded,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= 600 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 112,
          ),
          itemBuilder: (context, index) {
            final item = kpis[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              padding: const EdgeInsets.all(14),
              decoration: _dashCardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.$1,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(item.$4, size: 16, color: _accent),
                      ),
                    ],
                  ),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      color: _navy,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    item.$3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPersonalInfoPanel(GroupMember m) {
    final details = [
      ('Full Name', m.fullName, Icons.person_outline_rounded),
      ('Student ID', m.studentId, Icons.fingerprint_rounded),
      ('Address', m.address, Icons.location_city_rounded),
      ('Email Address', m.email, Icons.alternate_email_rounded),
      ('Focus Track', m.shortRole, Icons.work_outline_rounded),
      ('Bio Quote', m.bioQuote, Icons.format_quote_rounded),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.account_box_outlined,
            title: 'Personal Profile Summary',
            subtitle: 'Verified CA 02 details & clearly marked placeholders',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth >= 620 ? 3 : 1;
              if (cols == 1) {
                return Column(
                  children: details
                      .map(
                        (d) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _detailRowTile(d.$1, d.$2, d.$3),
                        ),
                      )
                      .toList(),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: details.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 74,
                ),
                itemBuilder: (context, i) {
                  final d = details[i];
                  return _detailRowTile(d.$1, d.$2, d.$3);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _detailRowTile(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _canvas,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 17, color: _accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 10.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 12.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftSkillsAnalytics(GroupMember m, double avgSkill) {
    final segmentColors = _segmentColorsForPalette();
    final safeIdx =
        m.softSkills.isEmpty ? 0 : _selectedSkillIdx.clamp(0, m.softSkills.length - 1);
    final selectedSkill = m.softSkills.isEmpty ? null : m.softSkills[safeIdx];

    final chartPanel = Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        children: [
          _sectionTitle(
            icon: Icons.pie_chart_rounded,
            title: 'Soft Skills Distribution',
            subtitle: 'Tap a skill to inspect segment',
          ),
          const SizedBox(height: 18),
          TweenAnimationBuilder<double>(
            key: ValueKey('ring_$_accentIdx'),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOutCubic,
            builder: (context, animValue, _) {
              return SizedBox(
                width: 176,
                height: 176,
                child: CustomPaint(
                  painter: _SoftSkillsCircularChartPainter(
                    skills: m.softSkills,
                    colors: segmentColors,
                    selectedIndex: safeIdx,
                    sweepFactor: animValue,
                    trackColor: _canvas,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedSkill != null
                              ? '${(selectedSkill.level * 100).round()}%'
                              : '${(avgSkill * 100).round()}%',
                          style: TextStyle(
                            color: _navy,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            selectedSkill?.name ?? 'Avg Index',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: _accent,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: selectedSkill == null
                ? const SizedBox.shrink()
                : Container(
                    key: ValueKey(selectedSkill.name),
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _canvas,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _border),
                    ),
                    child: Text(
                      selectedSkill.description.isNotEmpty
                          ? selectedSkill.description
                          : selectedSkill.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 12.2,
                        height: 1.35,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );

    final breakdownPanel = Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.bar_chart_rounded,
            title: 'Soft Skills Breakdown',
            subtitle: 'Proficiency bars (placeholder ratings for CV skills)',
          ),
          const SizedBox(height: 14),
          ...List.generate(m.softSkills.length, (i) {
            final s = m.softSkills[i];
            final color = segmentColors[i % segmentColors.length];
            final isSelected = i == safeIdx;
            return InkWell(
              onTap: () => setState(() => _selectedSkillIdx = i),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? color.withValues(alpha: 0.45)
                        : Colors.transparent,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  s.name,
                                  style: const TextStyle(
                                    color: _ink,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${(s.level * 100).round()}%',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w800,
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: s.level),
                      duration: const Duration(milliseconds: 550),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, _) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: val.clamp(0.0, 1.0),
                            minHeight: 7,
                            backgroundColor: _canvas,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 660) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 5, child: chartPanel),
              const SizedBox(width: 14),
              Expanded(flex: 6, child: breakdownPanel),
            ],
          );
        }
        return Column(
          children: [
            chartPanel,
            const SizedBox(height: 14),
            breakdownPanel,
          ],
        );
      },
    );
  }

  Widget _buildAcademicsDataTable(GroupMember m) {
    final filtered = m.qualifications.where((q) {
      final isCert = q.level.toLowerCase().contains('cert');
      switch (_academicFilter) {
        case _AcademicFilter.all:
          return true;
        case _AcademicFilter.education:
          return !isCert;
        case _AcademicFilter.certificates:
          return isCert;
      }
    }).toList();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 8,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _sectionTitle(
                icon: Icons.table_chart_outlined,
                title: 'Academic Qualifications & Certifications',
                subtitle: '${filtered.length} records displayed',
              ),
              TextButton.icon(
                onPressed: () =>
                    setState(() => _compactTable = !_compactTable),
                icon: Icon(
                  _compactTable ? Icons.unfold_more : Icons.unfold_less,
                  size: 18,
                  color: _accent,
                ),
                label: Text(
                  _compactTable ? 'Full Spacing' : 'Compact',
                  style: TextStyle(
                    color: _accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _filterChip('All (${m.qualifications.length})', _AcademicFilter.all),
              _filterChip('Education', _AcademicFilter.education),
              _filterChip('Certifications', _AcademicFilter.certificates),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: SingleChildScrollView(
              key: ValueKey('${_academicFilter.name}_$_compactTable'),
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 620),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(_canvas),
                  dataRowMinHeight: _compactTable ? 42 : 52,
                  dataRowMaxHeight: _compactTable ? 56 : 72,
                  columnSpacing: _compactTable ? 16 : 26,
                  border: TableBorder.all(
                    color: _border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Year',
                        style: TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Level',
                        style: TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Qualification',
                        style: TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Institution',
                        style: TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                          color: _navy,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                  rows: filtered.map((q) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            q.year,
                            style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              q.level,
                              style: TextStyle(
                                color: _accent,
                                fontWeight: FontWeight.w800,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 230),
                            child: Text(
                              q.title,
                              style: const TextStyle(
                                color: _ink,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.8,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: Text(
                              q.institution,
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            q.gradeOrStatus ?? '—',
                            style: TextStyle(
                              color: (q.gradeOrStatus ?? '')
                                      .toLowerCase()
                                      .contains('placeholder')
                                  ? _muted
                                  : _navy,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, _AcademicFilter filter) {
    final selected = _academicFilter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => _academicFilter = filter),
      selectedColor: _navy,
      backgroundColor: _canvas,
      side: BorderSide(color: selected ? _navy : _border),
      labelStyle: TextStyle(
        color: selected ? Colors.white : _ink,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
      showCheckmark: false,
    );
  }

  Widget _buildTalentsGrid(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            icon: Icons.grid_view_rounded,
            title: 'Talents, Capabilities & Hobbies',
            subtitle: 'Creative content, marketing, web & placeholder hobbies',
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final int cols;
              if (constraints.maxWidth >= 700) {
                cols = 3;
              } else if (constraints.maxWidth >= 460) {
                cols = 2;
              } else {
                cols = 1;
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: m.talents.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: cols == 1 ? 132 : 154,
                ),
                itemBuilder: (context, index) {
                  final t = m.talents[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _canvas,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: _border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: _accent.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  t.category.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _accent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              _iconForCategory(t.category),
                              size: 18,
                              color: _navy,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _navy,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Text(
                            t.detail,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 12,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('content') || lower.contains('vlog')) {
      return Icons.videocam_outlined;
    }
    if (lower.contains('design') || lower.contains('creative')) {
      return Icons.brush_outlined;
    }
    if (lower.contains('marketing')) {
      return Icons.campaign_outlined;
    }
    if (lower.contains('tech')) {
      return Icons.code_rounded;
    }
    return Icons.interests_outlined;
  }

  Widget _sectionTitle({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _navy.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: _accent),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _navy,
                  fontWeight: FontWeight.w800,
                  fontSize: 15.5,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 11.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxDecoration _dashCardDecoration() {
    return BoxDecoration(
      color: _cardWhite,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _border),
      boxShadow: [
        BoxShadow(
          color: _navy.withValues(alpha: 0.04),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}

class _SoftSkillsCircularChartPainter extends CustomPainter {
  _SoftSkillsCircularChartPainter({
    required this.skills,
    required this.colors,
    required this.selectedIndex,
    required this.sweepFactor,
    required this.trackColor,
  });

  final List<SoftSkill> skills;
  final List<Color> colors;
  final int selectedIndex;
  final double sweepFactor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const strokeWidth = 18.0;
    final radius = (math.min(size.width, size.height) - strokeWidth - 8) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, bgPaint);

    if (skills.isEmpty) return;

    final totalWeight = skills.fold<double>(
      0,
      (sum, s) => sum + (s.level > 0 ? s.level : 1.0),
    );
    const gapRadians = 0.06;
    final usableCircle =
        (2 * math.pi - gapRadians * skills.length) * sweepFactor.clamp(0.0, 1.0);

    var startAngle = -math.pi / 2;
    for (var i = 0; i < skills.length; i++) {
      final weight = skills[i].level > 0 ? skills[i].level : 1.0;
      final segmentSweep = (weight / totalWeight) * usableCircle;
      final isSelected = i == selectedIndex;

      final paint = Paint()
        ..color = colors[i % colors.length]
        ..strokeWidth = isSelected ? strokeWidth + 4 : strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      if (segmentSweep > 0.01) {
        canvas.drawArc(rect, startAngle, segmentSweep, false, paint);
      }
      startAngle += segmentSweep + (gapRadians * sweepFactor.clamp(0.0, 1.0));
    }
  }

  @override
  bool shouldRepaint(covariant _SoftSkillsCircularChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.sweepFactor != sweepFactor ||
        oldDelegate.colors != colors ||
        oldDelegate.skills != skills;
  }
}
