import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 09 BIO SCREEN — Design Style: Modern Dashboard-Style Profile
/// ============================================================================
/// Contributor: Member 09
/// SaaS analytics dashboard layout featuring KPI summary tiles, CustomPaint
/// radial competency chart, DataTable for academic records, interactive accent
/// switcher, and modular dashboard widgets.
/// ============================================================================
class Member09Screen extends StatefulWidget {
  const Member09Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member09Screen> createState() => _Member09ScreenState();
}

class _Member09ScreenState extends State<Member09Screen> {
  static const Color _bg = Color(0xFFF1F5F9);
  static const Color _ink = Color(0xFF0F172A);
  static const Color _muted = Color(0xFF64748B);

  final List<Color> _accentChoices = const [
    Color(0xFF2563EB),
    Color(0xFF10B981),
    Color(0xFF6366F1),
  ];

  int _accentIdx = 0;
  bool _showCompactTable = false;

  Color get _primary => _accentChoices[_accentIdx];

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final avgSkill = m.softSkills.isEmpty
        ? 0.0
        : m.softSkills.map((s) => s.level).reduce((a, b) => a + b) /
            m.softSkills.length;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _ink,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.dashboard_rounded, color: _primary, size: 22),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Member 09 Dashboard',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Switch dashboard accent',
            onPressed: () {
              setState(() => _accentIdx = (_accentIdx + 1) % _accentChoices.length);
            },
            icon: Icon(Icons.color_lens_outlined, color: _primary),
          ),
          FavoriteButton(
            memberId: m.id,
            activeColor: _primary,
            inactiveColor: _muted,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopProfilePanel(m),
                const SizedBox(height: 14),
                _buildKpiGrid(m, avgSkill),
                const SizedBox(height: 14),
                _buildAnalyticsAndSkillsRow(m, avgSkill),
                const SizedBox(height: 14),
                _buildAcademicsDataTable(m),
                const SizedBox(height: 14),
                _buildTalentsPanel(m),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopProfilePanel(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 540;
          final identity = Row(
            children: [
              Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: _primary,
                  width: 76,
                  height: 76,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            m.studentId,
                            style: TextStyle(
                              color: _primary,
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            m.shortRole,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      m.fullName,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m.shortDescription,
                      style: const TextStyle(color: _muted, fontSize: 12.5),
                    ),
                  ],
                ),
              ),
            ],
          );

          final contactMeta = Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 16, color: _primary),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        m.address,
                        style: const TextStyle(color: _ink, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 16, color: _primary),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        m.email,
                        style: const TextStyle(color: _ink, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          if (wide) {
            return Row(
              children: [
                Expanded(flex: 3, child: identity),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: contactMeta),
              ],
            );
          }

          return Column(
            children: [
              identity,
              const SizedBox(height: 12),
              contactMeta,
            ],
          );
        },
      ),
    );
  }

  Widget _buildKpiGrid(GroupMember m, double avgSkill) {
    final kpis = [
      ('Qualifications', '${m.qualifications.length}', Icons.school_outlined),
      ('Soft Skills', '${m.softSkills.length}', Icons.psychology_outlined),
      ('Special Talents', '${m.talents.length}', Icons.auto_awesome_outlined),
      ('Skill Avg', '${(avgSkill * 100).round()}%', Icons.insights_rounded),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= 560 ? 4 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: kpis.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 98,
          ),
          itemBuilder: (context, index) {
            final item = kpis[index];
            return Container(
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(item.$3, size: 18, color: _primary),
                    ],
                  ),
                  Text(
                    item.$2,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
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

  Widget _buildAnalyticsAndSkillsRow(GroupMember m, double avgSkill) {
    final ringCard = Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        children: [
          const Text(
            'Overall Competency',
            style: TextStyle(
              color: _ink,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 128,
            height: 128,
            child: CustomPaint(
              painter: _SkillRingPainter(
                progress: avgSkill,
                color: _primary,
                trackColor: const Color(0xFFE2E8F0),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(avgSkill * 100).round()}%',
                      style: TextStyle(
                        color: _primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                      'Avg Index',
                      style: TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '"${m.bioQuote}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _muted,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );

    final barsCard = Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Soft Skills Breakdown',
            style: TextStyle(
              color: _ink,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          ...m.softSkills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.name,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                        ),
                      ),
                      Text(
                        '${(s.level * 100).round()}%',
                        style: TextStyle(
                          color: _primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: s.level,
                      minHeight: 8,
                      backgroundColor: _bg,
                      valueColor: AlwaysStoppedAnimation<Color>(_primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: ringCard),
              const SizedBox(width: 14),
              Expanded(flex: 3, child: barsCard),
            ],
          );
        }
        return Column(
          children: [
            ringCard,
            const SizedBox(height: 14),
            barsCard,
          ],
        );
      },
    );
  }

  Widget _buildAcademicsDataTable(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Academic Qualifications Log',
                  style: TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.5,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    setState(() => _showCompactTable = !_showCompactTable),
                child: Text(_showCompactTable ? 'Full View' : 'Compact View'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(_bg),
              columnSpacing: _showCompactTable ? 18 : 28,
              columns: const [
                DataColumn(label: Text('Year')),
                DataColumn(label: Text('Level')),
                DataColumn(label: Text('Qualification')),
                DataColumn(label: Text('Institution')),
              ],
              rows: m.qualifications
                  .map(
                    (q) => DataRow(
                      cells: [
                        DataCell(Text(q.year)),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              q.level,
                              style: TextStyle(
                                color: _primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Text(q.title)),
                        DataCell(Text(q.institution)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTalentsPanel(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _dashCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Special Talents & Hobbies',
            style: TextStyle(
              color: _ink,
              fontWeight: FontWeight.w700,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: m.talents.map((t) {
              return Container(
                width: 240,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _bg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.category.toUpperCase(),
                      style: TextStyle(
                        color: _primary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.title,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.detail,
                      style: const TextStyle(color: _muted, fontSize: 12.5),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _dashCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFFE2E8F0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class _SkillRingPainter extends CustomPainter {
  _SkillRingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
  });

  final double progress;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 12.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - stroke) / 2;

    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SkillRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
