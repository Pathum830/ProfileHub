import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 07 BIO SCREEN — Design Style: Dark Theme / Cyberpunk Profile
/// ============================================================================
/// Contributor: Member 07
/// Deep obsidian dark-theme interface with hexagonal ClipPath avatar,
/// monospace technical badges, neon cyan & violet borders, and SegmentedButton
/// interactive module switching.
/// ============================================================================
class Member07Screen extends StatefulWidget {
  const Member07Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member07Screen> createState() => _Member07ScreenState();
}

class _Member07ScreenState extends State<Member07Screen> {
  static const Color _obsidian = Color(0xFF090D16);
  static const Color _panel = Color(0xFF111827);
  static const Color _cyan = Color(0xFF00F5D4);
  static const Color _violet = Color(0xFF9B5DE5);
  static const Color _textLight = Color(0xFFE2E8F0);
  static const Color _textDim = Color(0xFF94A3B8);

  int _selectedModule = 0; // 0: All, 1: Edu, 2: Skills & Talents

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: _obsidian,
      ),
      child: Scaffold(
        backgroundColor: _obsidian,
        appBar: AppBar(
          backgroundColor: _obsidian,
          foregroundColor: _cyan,
          elevation: 0,
          title: const Text(
            'SYS://MEMBER_07',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          actions: [
            FavoriteButton(
              memberId: m.id,
              activeColor: _cyan,
              inactiveColor: _textDim,
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildCyberHeader(m),
                  const SizedBox(height: 16),
                  _buildTerminalContact(m),
                  const SizedBox(height: 18),
                  SegmentedButton<int>(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return _cyan.withValues(alpha: 0.16);
                        }
                        return _panel;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return _cyan;
                        }
                        return _textDim;
                      }),
                      side: WidgetStateProperty.all(
                        BorderSide(color: _violet.withValues(alpha: 0.5)),
                      ),
                    ),
                    segments: const [
                      ButtonSegment(value: 0, label: Text('ALL_MODULES')),
                      ButtonSegment(value: 1, label: Text('EDU_LOG')),
                      ButtonSegment(value: 2, label: Text('SKILLS_OPS')),
                    ],
                    selected: {_selectedModule},
                    onSelectionChanged: (val) =>
                        setState(() => _selectedModule = val.first),
                  ),
                  const SizedBox(height: 20),
                  if (_selectedModule == 0 || _selectedModule == 1) ...[
                    _buildCyberTitle('ACADEMIC_RECORDS'),
                    const SizedBox(height: 10),
                    ...m.qualifications.map(_buildCyberEduTile),
                    const SizedBox(height: 20),
                  ],
                  if (_selectedModule == 0 || _selectedModule == 2) ...[
                    _buildCyberTitle('SOFT_SKILL_MATRIX'),
                    const SizedBox(height: 10),
                    _buildSkillGrid(m),
                    const SizedBox(height: 22),
                    _buildCyberTitle('SPECIAL_TALENTS'),
                    const SizedBox(height: 10),
                    ...m.talents.map(_buildTalentCyberCard),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCyberHeader(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _cyan.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(
            color: _cyan.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: _cyan.withValues(alpha: 0.35),
                  blurRadius: 18,
                ),
              ],
            ),
            child: ClipPath(
              clipper: _HexagonClipper(),
              child: Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: _cyan,
                  width: 100,
                  height: 108,
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: _cyan,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'ACTIVE • ${m.studentId}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _cyan,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  m.fullName,
                  style: const TextStyle(
                    color: _textLight,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m.shortRole,
                  style: const TextStyle(
                    color: _violet,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  m.bioQuote,
                  style: const TextStyle(
                    color: _textDim,
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerminalContact(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF05080F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _violet.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '> node.address = "${m.address}"',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _cyan,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '> node.email   = "${m.email}"',
            style: const TextStyle(
              fontFamily: 'monospace',
              color: _textLight,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCyberTitle(String title) {
    return Row(
      children: [
        const Text(
          '// ',
          style: TextStyle(
            fontFamily: 'monospace',
            color: _cyan,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'monospace',
            color: _textLight,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
            fontSize: 13.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCyberEduTile(AcademicQualification q) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _violet.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _violet.withValues(alpha: 0.5)),
            ),
            child: Text(
              q.year,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: _violet,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${q.level}: ${q.title}',
                  style: const TextStyle(
                    color: _textLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  q.gradeOrStatus != null
                      ? '${q.institution} • ${q.gradeOrStatus}'
                      : q.institution,
                  style: const TextStyle(color: _textDim, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillGrid(GroupMember m) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= 500 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: m.softSkills.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 88,
          ),
          itemBuilder: (context, index) {
            final s = m.softSkills[index];
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _cyan.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          s.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _textLight,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        '${(s.level * 100).round()}%',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          color: _cyan,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: s.level,
                      minHeight: 5,
                      backgroundColor: const Color(0xFF1E293B),
                      valueColor: const AlwaysStoppedAnimation<Color>(_cyan),
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

  Widget _buildTalentCyberCard(SpecialTalent t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: _panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: _cyan, width: 3.5),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.terminal_rounded, color: _cyan, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${t.title} [${t.category}]',
                      style: const TextStyle(
                        color: _textLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      t.detail,
                      style: const TextStyle(color: _textDim, fontSize: 12.5),
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
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = size.width / 2;
    final ry = size.height / 2;

    for (int i = 0; i < 6; i++) {
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
