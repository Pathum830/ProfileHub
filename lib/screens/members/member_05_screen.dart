import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 05 BIO SCREEN — Design Style: Timeline-Based Biography
/// ============================================================================
/// Contributor: Member 05
/// Warm archival parchment aesthetic featuring a custom ClipPath wave header,
/// interactive chronological timeline nodes (AnimatedCrossFade), and journal
/// skill/talent columns.
/// ============================================================================
class Member05Screen extends StatefulWidget {
  const Member05Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member05Screen> createState() => _Member05ScreenState();
}

class _Member05ScreenState extends State<Member05Screen> {
  static const Color _parchment = Color(0xFFF3EFE0);
  static const Color _cardBg = Color(0xFFFCFBF4);
  static const Color _ink = Color(0xFF1F2937);
  static const Color _teal = Color(0xFF1B6B5A);
  static const Color _ochre = Color(0xFFB45309);

  int _expandedMilestone = 0;

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return Scaffold(
      backgroundColor: _parchment,
      appBar: AppBar(
        backgroundColor: _teal,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Chronicle • Member 05',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          FavoriteButton(
            memberId: m.id,
            activeColor: const Color(0xFFFBBF24),
            inactiveColor: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWaveHeader(m),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 740),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 12, 18, 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactLedger(m),
                      const SizedBox(height: 24),
                      const Text(
                        'Academic Timeline',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Tap any milestone node to inspect details',
                        style: TextStyle(color: Color(0xFF6B7280), fontSize: 12.5),
                      ),
                      const SizedBox(height: 16),
                      _buildTimeline(m),
                      const SizedBox(height: 24),
                      _buildJournalColumns(m),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaveHeader(GroupMember m) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: Container(
        width: double.infinity,
        color: _teal,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 46),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _parchment,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Hero(
                    tag: 'photo_${m.id}',
                    child: MemberPhoto(
                      assetPath: m.photoAsset,
                      memberNumber: m.memberNumber,
                      accentColor: _teal,
                      width: 94,
                      height: 108,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.studentId,
                        style: const TextStyle(
                          color: Color(0xFFA7F3D0),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        m.shortRole,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactLedger(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD6D3C4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${m.bioQuote}"',
            style: const TextStyle(
              color: _teal,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const Divider(height: 22, color: Color(0xFFE5E1D2)),
          Wrap(
            spacing: 24,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.home_outlined, size: 18, color: _ochre),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      m.address,
                      style: const TextStyle(color: _ink, fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.mail_outline, size: 18, color: _ochre),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      m.email,
                      style: const TextStyle(color: _ink, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(GroupMember m) {
    return Column(
      children: List.generate(m.qualifications.length, (index) {
        final q = m.qualifications[index];
        final isLast = index == m.qualifications.length - 1;
        final isExpanded = _expandedMilestone == index;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _expandedMilestone = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isExpanded ? _teal : _cardBg,
                          border: Border.all(color: _teal, width: 2.5),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isExpanded ? Colors.white : _teal,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2.5,
                          color: _teal.withValues(alpha: 0.35),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => setState(() => _expandedMilestone = index),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _cardBg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isExpanded ? _teal : const Color(0xFFD6D3C4),
                          width: isExpanded ? 1.8 : 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                q.year,
                                style: const TextStyle(
                                  color: _ochre,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                q.level,
                                style: const TextStyle(
                                  color: _teal,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            q.title,
                            style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          AnimatedCrossFade(
                            duration: const Duration(milliseconds: 220),
                            crossFadeState: isExpanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            firstChild: const SizedBox.shrink(),
                            secondChild: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                q.gradeOrStatus != null
                                    ? '${q.institution} • Result: ${q.gradeOrStatus}'
                                    : q.institution,
                                style: const TextStyle(
                                  color: Color(0xFF4B5563),
                                  fontSize: 13,
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
    );
  }

  Widget _buildJournalColumns(GroupMember m) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 560;
        final skillsCard = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD6D3C4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Soft Skills',
                style: TextStyle(
                  color: _ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              ...m.softSkills.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline, size: 18, color: _teal),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _ink,
                              ),
                            ),
                            if (s.description.isNotEmpty)
                              Text(
                                s.description,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFF4B5563),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        final talentsCard = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFD6D3C4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Special Talents & Hobbies',
                style: TextStyle(
                  color: _ink,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              ...m.talents.map(
                (t) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.bookmark_border_rounded, size: 18, color: _ochre),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${t.title} (${t.category})',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _ink,
                              ),
                            ),
                            Text(
                              t.detail,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: skillsCard),
              const SizedBox(width: 14),
              Expanded(child: talentsCard),
            ],
          );
        }

        return Column(
          children: [
            skillsCard,
            const SizedBox(height: 14),
            talentsCard,
          ],
        );
      },
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height - 26);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height - 20,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height - 40,
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
