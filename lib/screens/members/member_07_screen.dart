import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 07 BIO SCREEN — Design Style: Dark Cyberpunk / Futuristic Dashboard
/// ============================================================================
/// Contributor: Member 07 (Thuvijavanthy Yogaraj)
/// Deep black & dark navy dashboard accented with neon cyan, purple, and green.
/// Features:
/// - CustomClipper hexagonal portrait frame with animated neon HUD border
/// - CustomClipper chamfered futuristic panels & custom neon border painters
/// - Monospace telemetry labels paired with high-contrast readable typography
/// - SegmentedButton module switcher (All Systems / Edu Log / Skills & Ops)
/// - Technical log-style academic qualification cards
/// - Interactive soft skill indicators with segmented neon LED meters
/// - Neon talent & hobby modules plus verified CV project telemetry
/// - Bounded entrance & interaction-driven neon animations
/// ============================================================================
class Member07Screen extends StatefulWidget {
  const Member07Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member07Screen> createState() => _Member07ScreenState();
}

enum _CyberSection { all, eduLog, skillsOps }

class _Member07ScreenState extends State<Member07Screen>
    with SingleTickerProviderStateMixin {
  // Deep Black / Dark Navy & Neon Accent Palette
  static const Color _voidBlack = Color(0xFF04060D);
  static const Color _deepNavy = Color(0xFF0A1124);
  static const Color _panelNavy = Color(0xFF0F1830);
  static const Color _panelInner = Color(0xFF070C1A);
  static const Color _neonCyan = Color(0xFF00F5D4);
  static const Color _neonPurple = Color(0xFFA855F7);
  static const Color _neonGreen = Color(0xFF00FF9D);
  static const Color _textPrimary = Color(0xFFF1F5F9);
  static const Color _textSecondary = Color(0xFF94A3B8);
  static const Color _gridLine = Color(0xFF172442);

  late final AnimationController _bootController;
  _CyberSection _activeSection = _CyberSection.all;
  int? _selectedSkillIndex = 0;
  int? _selectedTalentIndex;
  int _skillScanKey = 0;

  @override
  void initState() {
    super.initState();
    _bootController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    )..forward();
  }

  @override
  void dispose() {
    _bootController.dispose();
    super.dispose();
  }

  void _copyValue(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _panelNavy,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: _neonGreen.withValues(alpha: 0.7)),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: _neonGreen, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'COPIED $label: $value',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 400;
    final isWide = screenWidth >= 600;
    final horizontalPadding = isWide
        ? 28.0
        : isCompact
            ? 14.0
            : 18.0;

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _voidBlack,
        colorScheme: const ColorScheme.dark(
          primary: _neonCyan,
          secondary: _neonPurple,
          tertiary: _neonGreen,
          surface: _panelNavy,
        ),
      ),
      child: Scaffold(
        backgroundColor: _voidBlack,
        appBar: AppBar(
          backgroundColor: _voidBlack.withValues(alpha: 0.94),
          foregroundColor: _neonCyan,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 4,
          title: Row(
            children: [
              _NeonPulseDot(
                color: _neonGreen,
                animation: _bootController,
              ),
              const SizedBox(width: 8),
              const Flexible(
                child: Text(
                  'SYS://MEMBER_07',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: _neonCyan,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _neonGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _neonGreen.withValues(alpha: 0.45)),
              ),
              child: const Center(
                child: Text(
                  'ONLINE',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: _neonGreen,
                  ),
                ),
              ),
            ),
            FavoriteButton(
              memberId: m.id,
              activeColor: _neonCyan,
              inactiveColor: _textSecondary,
            ),
            const SizedBox(width: 6),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.5),
            child: AnimatedBuilder(
              animation: _bootController,
              builder: (context, _) {
                return Container(
                  height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _neonCyan.withValues(alpha: 0.15 + 0.55 * _bootController.value),
                        _neonPurple.withValues(alpha: 0.7),
                        _neonGreen.withValues(alpha: 0.15 + 0.55 * _bootController.value),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        body: Stack(
          children: [
            // Deep black-to-navy atmospheric backdrop + cyber grid
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_voidBlack, _deepNavy, _voidBlack],
                  ),
                ),
                child: CustomPaint(
                  painter: _CyberGridPainter(
                    gridColor: _gridLine,
                    cyanGlow: _neonCyan,
                    purpleGlow: _neonPurple,
                    greenGlow: _neonGreen,
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  14,
                  horizontalPadding,
                  36,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 780),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _CyberEntrance(
                          controller: _bootController,
                          start: 0.0,
                          end: 0.45,
                          child: _buildIdentityHeroPanel(m, isCompact, isWide),
                        ),
                        const SizedBox(height: 16),
                        _CyberEntrance(
                          controller: _bootController,
                          start: 0.12,
                          end: 0.58,
                          child: _buildPersonalInfoPanel(m),
                        ),
                        const SizedBox(height: 18),
                        _CyberEntrance(
                          controller: _bootController,
                          start: 0.22,
                          end: 0.68,
                          child: _buildModuleSegmentedBar(isCompact),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 280),
                          curve: Curves.easeOutCubic,
                          alignment: Alignment.topCenter,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (_activeSection == _CyberSection.all ||
                                  _activeSection == _CyberSection.eduLog) ...[
                                _CyberEntrance(
                                  controller: _bootController,
                                  start: 0.30,
                                  end: 0.78,
                                  child: _buildAcademicLogsSection(m),
                                ),
                                if (m.id == 'member_07') ...[
                                  const SizedBox(height: 20),
                                  _CyberEntrance(
                                    controller: _bootController,
                                    start: 0.36,
                                    end: 0.84,
                                    child: _buildDesignProjectsSection(),
                                  ),
                                ],
                                const SizedBox(height: 22),
                              ],
                              if (_activeSection == _CyberSection.all ||
                                  _activeSection == _CyberSection.skillsOps) ...[
                                _CyberEntrance(
                                  controller: _bootController,
                                  start: 0.42,
                                  end: 0.90,
                                  child: _buildSoftSkillsSection(m),
                                ),
                                const SizedBox(height: 22),
                                _CyberEntrance(
                                  controller: _bootController,
                                  start: 0.52,
                                  end: 1.0,
                                  child: _buildTalentsSection(m),
                                ),
                              ],
                            ],
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
      ),
    );
  }

  Widget _buildIdentityHeroPanel(
    GroupMember m,
    bool isCompact,
    bool isWide,
  ) {
    final hexAvatar = _HexPhotoFrame(
      member: m,
      size: isCompact ? 116 : 128,
      animation: _bootController,
      cyanColor: _neonCyan,
      purpleColor: _neonPurple,
      greenColor: _neonGreen,
    );

    final identityDetails = Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Wrap(
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          spacing: 8,
          runSpacing: 6,
          children: [
            _MonoTagChip(
              label: 'NODE_${m.memberNumber.toString().padLeft(2, '0')}',
              accentColor: _neonGreen,
              leadingDot: true,
            ),
            _MonoTagChip(
              label: m.designStyleName.toUpperCase(),
              accentColor: _neonPurple,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          m.fullName,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: _textPrimary,
            fontSize: isCompact ? 22 : 25,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          m.shortRole,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
            color: _neonCyan,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _panelInner,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _neonCyan.withValues(alpha: 0.3)),
          ),
          child: Text(
            'ID // ${m.studentId}',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );

    return _CyberPanel(
      accentColor: _neonCyan,
      secondaryColor: _neonPurple,
      padding: EdgeInsets.all(isCompact ? 16 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                hexAvatar,
                const SizedBox(width: 22),
                Expanded(child: identityDetails),
              ],
            )
          else
            Column(
              children: [
                hexAvatar,
                const SizedBox(height: 16),
                identityDetails,
              ],
            ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _panelInner.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _gridLine),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '// PROFILE_SUMMARY',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: _neonCyan,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  m.shortDescription,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 13.5,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: _neonPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: const Border(
                      left: BorderSide(color: _neonPurple, width: 3),
                    ),
                  ),
                  child: Text(
                    '"${m.bioQuote}"',
                    style: const TextStyle(
                      color: Color(0xFFCBD5E1),
                      fontSize: 12.8,
                      fontStyle: FontStyle.italic,
                      height: 1.45,
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

  Widget _buildPersonalInfoPanel(GroupMember m) {
    final isMember07 = m.id == 'member_07';

    return _CyberPanel(
      accentColor: _neonPurple,
      secondaryColor: _neonGreen,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: _HudSectionHeader(
                  tag: '01',
                  title: 'PERSONAL_TELEMETRY',
                  accentColor: _neonPurple,
                ),
              ),
              _MonoTagChip(
                label: 'VERIFIED_NODE',
                accentColor: _neonGreen,
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final twoCols = constraints.maxWidth >= 520;
              final locationTile = _TerminalInfoRow(
                icon: Icons.location_on_outlined,
                monoLabel: 'NODE.ADDRESS',
                value: m.address,
                accentColor: _neonCyan,
              );
              final emailTile = _TerminalInfoRow(
                icon: Icons.alternate_email_rounded,
                monoLabel: 'NODE.EMAIL',
                value: m.email,
                accentColor: _neonGreen,
                onCopy: () => _copyValue('EMAIL', m.email),
              );

              if (twoCols) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: locationTile),
                    const SizedBox(width: 12),
                    Expanded(child: emailTile),
                  ],
                );
              }
              return Column(
                children: [
                  locationTile,
                  const SizedBox(height: 10),
                  emailTile,
                ],
              );
            },
          ),
          if (isMember07) ...[
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final twoCols = constraints.maxWidth >= 520;
                final phoneTile = _TerminalInfoRow(
                  icon: Icons.phone_android_rounded,
                  monoLabel: 'NODE.PHONE',
                  value: '+94 77 345 6421',
                  accentColor: _neonPurple,
                  onCopy: () => _copyValue('PHONE', '+94 77 345 6421'),
                );
                final linksTile = _TerminalInfoRow(
                  icon: Icons.hub_outlined,
                  monoLabel: 'NODE.LINKS',
                  value: 'linkedin.com/in/thuvi06 • github.com/Thuvijavanthy-Yogaraj',
                  accentColor: _neonCyan,
                  onCopy: () => _copyValue(
                    'GITHUB',
                    'https://github.com/Thuvijavanthy-Yogaraj',
                  ),
                );

                if (twoCols) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: phoneTile),
                      const SizedBox(width: 12),
                      Expanded(child: linksTile),
                    ],
                  );
                }
                return Column(
                  children: [
                    phoneTile,
                    const SizedBox(height: 10),
                    linksTile,
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: _panelInner,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _gridLine),
              ),
              child: const Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'LANG_BUS://',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _textSecondary,
                    ),
                  ),
                  _MonoTagChip(label: 'ENGLISH · FLUENT', accentColor: _neonCyan),
                  _MonoTagChip(label: 'TAMIL · NATIVE', accentColor: _neonGreen),
                  _MonoTagChip(label: 'SINHALA · BASIC', accentColor: _neonPurple),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModuleSegmentedBar(bool isCompact) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: _panelInner,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _neonPurple.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: _neonPurple.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SegmentedButton<_CyberSection>(
        showSelectedIcon: false,
        style: ButtonStyle(
          visualDensity: isCompact ? VisualDensity.compact : VisualDensity.standard,
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(
              horizontal: isCompact ? 6 : 12,
              vertical: 10,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _neonCyan.withValues(alpha: 0.16);
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _neonCyan;
            }
            return _textSecondary;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return BorderSide(color: _neonCyan.withValues(alpha: 0.75));
            }
            return BorderSide(color: _gridLine.withValues(alpha: 0.9));
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontFamily: 'monospace',
              fontSize: isCompact ? 11 : 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        segments: const [
          ButtonSegment<_CyberSection>(
            value: _CyberSection.all,
            icon: Icon(Icons.dashboard_customize_outlined, size: 16),
            label: Text('ALL_SYS', maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          ButtonSegment<_CyberSection>(
            value: _CyberSection.eduLog,
            icon: Icon(Icons.terminal_rounded, size: 16),
            label: Text('EDU_LOG', maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
          ButtonSegment<_CyberSection>(
            value: _CyberSection.skillsOps,
            icon: Icon(Icons.memory_rounded, size: 16),
            label: Text('SKILLS', maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ],
        selected: {_activeSection},
        onSelectionChanged: (selection) {
          setState(() => _activeSection = selection.first);
        },
      ),
    );
  }

  Widget _buildAcademicLogsSection(GroupMember m) {
    final quals = m.qualifications;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HudSectionHeader(
          tag: '02',
          title: 'ACADEMIC_LOG_RECORDS',
          accentColor: _neonCyan,
          trailing: Text(
            '${quals.length} ENTRIES',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < quals.length; i++)
          _AcademicLogCard(
            index: i + 1,
            qualification: quals[i],
            accentColor: i.isEven ? _neonCyan : _neonPurple,
            statusColor: _resolveStatusColor(quals[i].gradeOrStatus),
          ),
      ],
    );
  }

  Color _resolveStatusColor(String? status) {
    final normalized = (status ?? '').toLowerCase();
    if (normalized.contains('completed')) return _neonGreen;
    if (normalized.contains('ongoing')) return _neonCyan;
    return _neonPurple;
  }

  Widget _buildDesignProjectsSection() {
    const projects = [
      (
        code: 'PRJ_01',
        title: 'Pharmacy Management System',
        stack: 'Figma • PHP • HTML • CSS • JS',
        detail:
            'Designed dashboard screens and layout in Figma, then built a structured interface for managing pharmacy data.',
        color: _neonCyan,
      ),
      (
        code: 'PRJ_02',
        title: 'Smart Municipal Council – Complaint Module',
        stack: 'Figma • React.js • Spring Boot • PostgreSQL',
        detail:
            'Designed complaint module screens in Figma and built the React.js UI for clear, user-friendly complaint submissions.',
        color: _neonPurple,
      ),
      (
        code: 'PRJ_03',
        title: 'BookBridge – Student Book Exchange',
        stack: 'React.js • Java Spring Boot • MySQL',
        detail:
            'Built the full UI in React.js with search, sorting, Free/Exchange shelves, and profile listings.',
        color: _neonGreen,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _HudSectionHeader(
          tag: '02B',
          title: 'UIUX_PROJECT_LOGS',
          accentColor: _neonGreen,
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 600 ? 3 : 1;
            const spacing = 12.0;
            final width = cols == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing * 2) / 3;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: projects
                  .map(
                    (p) => SizedBox(
                      width: width,
                      child: _CyberPanel(
                        accentColor: p.color,
                        secondaryColor: _deepNavy,
                        chamferSize: 12,
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _MonoTagChip(label: p.code, accentColor: p.color),
                            const SizedBox(height: 8),
                            Text(
                              p.title,
                              style: const TextStyle(
                                color: _textPrimary,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              p.stack,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                color: p.color,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              p.detail,
                              style: const TextStyle(
                                color: _textSecondary,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSoftSkillsSection(GroupMember m) {
    final accentCycle = [_neonCyan, _neonPurple, _neonGreen, _neonCyan];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HudSectionHeader(
          tag: '03',
          title: 'SOFT_SKILL_INDICATORS',
          accentColor: _neonGreen,
          trailing: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => setState(() => _skillScanKey++),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: _neonCyan.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _neonCyan.withValues(alpha: 0.45)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.radar_rounded, size: 13, color: _neonCyan),
                  SizedBox(width: 5),
                  Text(
                    'RE-SCAN',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: _neonCyan,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tap any skill indicator to inspect telemetry and strength notes.',
          style: TextStyle(
            color: _textSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 540 ? 2 : 1;
            const spacing = 12.0;
            final itemWidth = cols == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing) / 2;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (var i = 0; i < m.softSkills.length; i++)
                  SizedBox(
                    width: itemWidth,
                    child: _InteractiveSkillNode(
                      key: ValueKey('skill_${i}_$_skillScanKey'),
                      index: i,
                      skill: m.softSkills[i],
                      accentColor: accentCycle[i % accentCycle.length],
                      isSelected: _selectedSkillIndex == i,
                      onTap: () {
                        setState(() {
                          _selectedSkillIndex =
                              _selectedSkillIndex == i ? null : i;
                        });
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTalentsSection(GroupMember m) {
    final moduleColors = [_neonCyan, _neonPurple, _neonGreen];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _HudSectionHeader(
          tag: '04',
          title: 'TALENTS_&_HOBBY_MODULES',
          accentColor: _neonPurple,
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final cols = constraints.maxWidth >= 520 ? 2 : 1;
            const spacing = 12.0;
            final itemWidth = cols == 1
                ? constraints.maxWidth
                : (constraints.maxWidth - spacing) / 2;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                for (var i = 0; i < m.talents.length; i++)
                  SizedBox(
                    width: itemWidth,
                    child: _NeonTalentModule(
                      index: i,
                      talent: m.talents[i],
                      accentColor: moduleColors[i % moduleColors.length],
                      isActive: _selectedTalentIndex == i,
                      onTap: () {
                        setState(() {
                          _selectedTalentIndex =
                              _selectedTalentIndex == i ? null : i;
                        });
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Chamfered futuristic panel using [CustomClipper] and neon border [CustomPainter].
class _CyberPanel extends StatelessWidget {
  const _CyberPanel({
    required this.child,
    required this.accentColor,
    required this.secondaryColor,
    this.padding = const EdgeInsets.all(16),
    this.chamferSize = 16,
  });

  final Widget child;
  final Color accentColor;
  final Color secondaryColor;
  final EdgeInsetsGeometry padding;
  final double chamferSize;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CyberBorderPainter(
        chamferSize: chamferSize,
        primaryColor: accentColor,
        secondaryColor: secondaryColor,
      ),
      child: ClipPath(
        clipper: _CyberChamferClipper(chamferSize: chamferSize),
        child: Container(
          color: _Member07ScreenState._panelNavy.withValues(alpha: 0.94),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class _HexPhotoFrame extends StatelessWidget {
  const _HexPhotoFrame({
    required this.member,
    required this.size,
    required this.animation,
    required this.cyanColor,
    required this.purpleColor,
    required this.greenColor,
  });

  final GroupMember member;
  final double size;
  final Animation<double> animation;
  final Color cyanColor;
  final Color purpleColor;
  final Color greenColor;

  @override
  Widget build(BuildContext context) {
    final outerSize = size + 18;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final glowStrength = 0.25 +
            0.20 * math.sin(animation.value * math.pi * 2).abs();
        return Container(
          width: outerSize,
          height: outerSize * 1.08,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: cyanColor.withValues(alpha: glowStrength),
                blurRadius: 24,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: purpleColor.withValues(alpha: glowStrength * 0.7),
                blurRadius: 28,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CustomPaint(
            painter: _HexNeonFramePainter(
              progress: animation.value,
              cyanColor: cyanColor,
              purpleColor: purpleColor,
              greenColor: greenColor,
            ),
            child: child,
          ),
        );
      },
      child: Center(
        child: ClipPath(
          clipper: _HexagonClipper(),
          child: Hero(
            tag: 'photo_${member.id}',
            child: MemberPhoto(
              assetPath: member.photoAsset,
              memberNumber: member.memberNumber,
              accentColor: cyanColor,
              width: size,
              height: size * 1.08,
            ),
          ),
        ),
      ),
    );
  }
}

class _TerminalInfoRow extends StatelessWidget {
  const _TerminalInfoRow({
    required this.icon,
    required this.monoLabel,
    required this.value,
    required this.accentColor,
    this.onCopy,
  });

  final IconData icon;
  final String monoLabel;
  final String value;
  final Color accentColor;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _Member07ScreenState._panelInner,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentColor.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accentColor.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, size: 17, color: accentColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '> $monoLabel',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: accentColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: _Member07ScreenState._textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          if (onCopy != null)
            IconButton(
              tooltip: 'Copy $monoLabel',
              visualDensity: VisualDensity.compact,
              onPressed: onCopy,
              icon: Icon(
                Icons.copy_rounded,
                size: 16,
                color: accentColor,
              ),
            ),
        ],
      ),
    );
  }
}

class _AcademicLogCard extends StatelessWidget {
  const _AcademicLogCard({
    required this.index,
    required this.qualification,
    required this.accentColor,
    required this.statusColor,
  });

  final int index;
  final AcademicQualification qualification;
  final Color accentColor;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final logCode = 'LOG_${index.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _Member07ScreenState._panelNavy.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _Member07ScreenState._gridLine),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '[$logCode]',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: accentColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        _MonoTagChip(
                          label: qualification.level.toUpperCase(),
                          accentColor: accentColor,
                        ),
                        _MonoTagChip(
                          label: qualification.year,
                          accentColor: _Member07ScreenState._textSecondary,
                        ),
                        if (qualification.gradeOrStatus != null)
                          _MonoTagChip(
                            label: qualification.gradeOrStatus!.toUpperCase(),
                            accentColor: statusColor,
                          ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      qualification.title,
                      style: const TextStyle(
                        color: _Member07ScreenState._textPrimary,
                        fontSize: 14.5,
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
                            Icons.account_balance_outlined,
                            size: 14,
                            color: _Member07ScreenState._textSecondary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            qualification.institution,
                            style: const TextStyle(
                              color: _Member07ScreenState._textSecondary,
                              fontSize: 12.8,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveSkillNode extends StatelessWidget {
  const _InteractiveSkillNode({
    super.key,
    required this.index,
    required this.skill,
    required this.accentColor,
    required this.isSelected,
    required this.onTap,
  });

  final int index;
  final SoftSkill skill;
  final Color accentColor;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final percent = (skill.level * 100).round();
    const totalSegments = 10;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: skill.level.clamp(0.0, 1.0)),
      duration: Duration(milliseconds: 650 + index * 110),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) {
        final litSegments = (animatedValue * totalSegments).round();
        final animatedPercent = (animatedValue * 100).round();

        return AnimatedScale(
          scale: isSelected ? 1.015 : 1.0,
          duration: const Duration(milliseconds: 180),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isSelected
                    ? _Member07ScreenState._panelNavy
                    : _Member07ScreenState._panelInner.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? accentColor
                      : accentColor.withValues(alpha: 0.30),
                  width: isSelected ? 1.5 : 1.0,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: accentColor.withValues(alpha: 0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 4),
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
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: accentColor.withValues(alpha: 0.7),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          skill.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _Member07ScreenState._textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$animatedPercent%',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: accentColor,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isSelected
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: _Member07ScreenState._textSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Segmented cyber LED indicator bar
                  Row(
                    children: List.generate(totalSegments, (segIndex) {
                      final active = segIndex < litSegments;
                      return Expanded(
                        child: Container(
                          height: 7,
                          margin: EdgeInsets.only(
                            right: segIndex == totalSegments - 1 ? 0 : 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: active
                                ? accentColor
                                : _Member07ScreenState._gridLine,
                            boxShadow: active
                                ? [
                                    BoxShadow(
                                      color: accentColor.withValues(alpha: 0.45),
                                      blurRadius: 6,
                                    ),
                                  ]
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 220),
                    crossFadeState: isSelected
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill.description.isNotEmpty
                                ? skill.description
                                : 'Verified skill telemetry node.',
                            style: const TextStyle(
                              color: _Member07ScreenState._textSecondary,
                              fontSize: 12.2,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'SIGNAL: ${percent >= 88 ? 'OPTIMAL' : 'STABLE'} • NODE_0${index + 1}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: accentColor.withValues(alpha: 0.9),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NeonTalentModule extends StatelessWidget {
  const _NeonTalentModule({
    required this.index,
    required this.talent,
    required this.accentColor,
    required this.isActive,
    required this.onTap,
  });

  final int index;
  final SpecialTalent talent;
  final Color accentColor;
  final bool isActive;
  final VoidCallback onTap;

  IconData _pickIcon(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('design')) return Icons.design_services_outlined;
    if (lower.contains('creative') || lower.contains('art')) {
      return Icons.palette_outlined;
    }
    if (lower.contains('tech')) return Icons.code_rounded;
    if (lower.contains('sport')) return Icons.bolt_rounded;
    return Icons.auto_awesome_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: isActive ? 0.22 : 0.08),
              blurRadius: isActive ? 20 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _CyberPanel(
          accentColor: accentColor,
          secondaryColor: isActive
              ? _Member07ScreenState._neonGreen
              : _Member07ScreenState._gridLine,
          chamferSize: 12,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: accentColor.withValues(alpha: 0.55),
                      ),
                    ),
                    child: Icon(
                      _pickIcon(talent.category),
                      color: accentColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _MonoTagChip(
                      label: talent.category.toUpperCase(),
                      accentColor: accentColor,
                    ),
                  ),
                  Text(
                    'M${(index + 1).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: accentColor.withValues(alpha: 0.8),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                talent.title,
                style: const TextStyle(
                  color: _Member07ScreenState._textPrimary,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                talent.detail,
                style: const TextStyle(
                  color: _Member07ScreenState._textSecondary,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HudSectionHeader extends StatelessWidget {
  const _HudSectionHeader({
    required this.tag,
    required this.title,
    required this.accentColor,
    this.trailing,
  });

  final String tag;
  final String title;
  final Color accentColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accentColor.withValues(alpha: 0.5)),
          ),
          child: Text(
            tag,
            style: TextStyle(
              fontFamily: 'monospace',
              color: accentColor,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '// $title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _Member07ScreenState._textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
}

class _MonoTagChip extends StatelessWidget {
  const _MonoTagChip({
    required this.label,
    required this.accentColor,
    this.leadingDot = false,
  });

  final String label;
  final Color accentColor;
  final bool leadingDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accentColor.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'monospace',
                color: accentColor,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeonPulseDot extends StatelessWidget {
  const _NeonPulseDot({
    required this.color,
    required this.animation,
  });

  final Color color;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final pulse = 0.6 + 0.4 * math.sin(animation.value * math.pi * 3).abs();
        return Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: pulse),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CyberEntrance extends StatelessWidget {
  const _CyberEntrance({
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
  });

  final Animation<double> controller;
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

/// Clips the portrait photograph into a sharp futuristic hexagon.
class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = size.width / 2;
    final ry = size.height / 2;

    for (var i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - (math.pi / 2);
      final x = cx + rx * math.cos(angle);
      final y = cy + ry * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Clips futuristic dashboard cards with angled cyberpunk chamfered corners.
class _CyberChamferClipper extends CustomClipper<Path> {
  const _CyberChamferClipper({this.chamferSize = 16});

  final double chamferSize;

  @override
  Path getClip(Size size) {
    final c = chamferSize.clamp(0.0, math.min(size.width, size.height) / 3);
    return Path()
      ..moveTo(c, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - c)
      ..lineTo(size.width - c, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, c)
      ..close();
  }

  @override
  bool shouldReclip(covariant _CyberChamferClipper oldClipper) =>
      oldClipper.chamferSize != chamferSize;
}

class _CyberBorderPainter extends CustomPainter {
  const _CyberBorderPainter({
    required this.chamferSize,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double chamferSize;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final c = chamferSize.clamp(0.0, math.min(size.width, size.height) / 3);
    final path = Path()
      ..moveTo(c, 0.75)
      ..lineTo(size.width - 0.75, 0.75)
      ..lineTo(size.width - 0.75, size.height - c)
      ..lineTo(size.width - c, size.height - 0.75)
      ..lineTo(0.75, size.height - 0.75)
      ..lineTo(0.75, c)
      ..close();

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.35
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryColor.withValues(alpha: 0.85),
          secondaryColor.withValues(alpha: 0.65),
          primaryColor.withValues(alpha: 0.35),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawPath(path, borderPaint);

    // Subtle HUD corner accent ticks
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..color = primaryColor;
    canvas.drawLine(Offset(c, 1), Offset(c + 18, 1), tickPaint);
    canvas.drawLine(
      Offset(size.width - c - 18, size.height - 1),
      Offset(size.width - c, size.height - 1),
      tickPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CyberBorderPainter oldDelegate) =>
      oldDelegate.primaryColor != primaryColor ||
      oldDelegate.secondaryColor != secondaryColor ||
      oldDelegate.chamferSize != chamferSize;
}

class _HexNeonFramePainter extends CustomPainter {
  const _HexNeonFramePainter({
    required this.progress,
    required this.cyanColor,
    required this.purpleColor,
    required this.greenColor,
  });

  final double progress;
  final Color cyanColor;
  final Color purpleColor;
  final Color greenColor;

  Path _buildHex(Size size, double inset) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = (size.width / 2) - inset;
    final ry = (size.height / 2) - inset;
    for (var i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - (math.pi / 2);
      final x = cx + rx * math.cos(angle);
      final y = cy + ry * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final outerPath = _buildHex(size, 2);
    final innerPath = _buildHex(size, 6.5);

    final outerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: math.pi * 2,
        transform: GradientRotation(progress * math.pi),
        colors: [cyanColor, purpleColor, greenColor, cyanColor],
      ).createShader(Offset.zero & size);

    final innerPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = cyanColor.withValues(alpha: 0.45);

    canvas.drawPath(outerPath, outerPaint);
    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant _HexNeonFramePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _CyberGridPainter extends CustomPainter {
  const _CyberGridPainter({
    required this.gridColor,
    required this.cyanGlow,
    required this.purpleGlow,
    required this.greenGlow,
  });

  final Color gridColor;
  final Color cyanGlow;
  final Color purpleGlow;
  final Color greenGlow;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = gridColor.withValues(alpha: 0.35)
      ..strokeWidth = 0.7;

    const step = 36.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // Subtle atmospheric neon radial glows
    _drawGlow(
      canvas,
      Offset(size.width * 0.9, size.height * 0.08),
      size.width * 0.45,
      cyanGlow.withValues(alpha: 0.09),
    );
    _drawGlow(
      canvas,
      Offset(size.width * 0.1, size.height * 0.55),
      size.width * 0.5,
      purpleGlow.withValues(alpha: 0.08),
    );
    _drawGlow(
      canvas,
      Offset(size.width * 0.85, size.height * 0.88),
      size.width * 0.4,
      greenGlow.withValues(alpha: 0.06),
    );
  }

  void _drawGlow(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
