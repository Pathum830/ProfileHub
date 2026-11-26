import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';
import 'package:provider/provider.dart';

/// MEMBER 03 BIO SCREEN — Design Style: Creative Portfolio Layout
/// ============================================================================
/// Contributor: Member 03
/// Bold neo-brutalist studio design with rotated Polaroid portrait, hard
/// offset shadows, PageView qualification carousel, and interactive applause.
/// ============================================================================
class Member03Screen extends StatefulWidget {
  const Member03Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member03Screen> createState() => _Member03ScreenState();
}

class _Member03ScreenState extends State<Member03Screen> {
  static const Color _cream = Color(0xFFFFFDF5);
  static const Color _ink = Color(0xFF111827);
  static const Color _coral = Color(0xFFFF4D6D);
  static const Color _cobalt = Color(0xFF4361EE);
  static const Color _sun = Color(0xFFFFD166);
  static const Color _mint = Color(0xFF06D6A0);

  late final PageController _pageController;
  int _currentEduPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BoxDecoration _brutalBox({Color color = Colors.white, double radius = 16}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: _ink, width: 2.5),
      boxShadow: const [
        BoxShadow(
          color: _ink,
          offset: Offset(5, 5),
          blurRadius: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final memberProvider = context.watch<MemberProvider>();
    final applause = memberProvider.endorsementCount(m.id);

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        backgroundColor: _sun,
        foregroundColor: _ink,
        elevation: 0,
        shape: const Border(bottom: BorderSide(color: _ink, width: 2.5)),
        title: const Text(
          'STUDIO // M-03',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        actions: [
          FavoriteButton(
            memberId: m.id,
            activeColor: _coral,
            inactiveColor: _ink,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 22, 18, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 740),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildPolaroidHero(m, applause, memberProvider),
                const SizedBox(height: 22),
                _buildContactStickers(m),
                const SizedBox(height: 24),
                _buildEducationCarousel(m),
                const SizedBox(height: 24),
                _buildSkillsStickerBoard(m),
                const SizedBox(height: 24),
                _buildTalentsShowcase(m),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolaroidHero(
    GroupMember m,
    int applause,
    MemberProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _brutalBox(color: _coral.withValues(alpha: 0.14), radius: 22),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 500;
          final polaroid = Transform.rotate(
            angle: -0.04,
            child: Container(
              width: 170,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 22),
              decoration: _brutalBox(color: Colors.white, radius: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'photo_${m.id}',
                    child: MemberPhoto(
                      assetPath: m.photoAsset,
                      memberNumber: m.memberNumber,
                      accentColor: _coral,
                      width: 146,
                      height: 146,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    m.studentId,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );

          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _cobalt,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _ink, width: 2),
                ),
                child: Text(
                  m.shortRole.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                m.fullName,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                m.shortDescription,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              InkWell(
                onTap: () => provider.addEndorsement(m.id),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                  decoration: _brutalBox(color: _sun, radius: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pan_tool_alt_rounded, size: 18, color: _ink),
                      const SizedBox(width: 8),
                      Text(
                        'Applaud Design ($applause)',
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                polaroid,
                const SizedBox(width: 24),
                Expanded(child: info),
              ],
            );
          }

          return Column(
            children: [
              polaroid,
              const SizedBox(height: 20),
              info,
            ],
          );
        },
      ),
    );
  }

  Widget _buildContactStickers(GroupMember m) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: _brutalBox(color: _mint.withValues(alpha: 0.35)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 17, color: _ink),
                    SizedBox(width: 6),
                    Text(
                      'STUDIO BASE',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        color: _ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  m.address,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: _ink,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: _brutalBox(color: _sun.withValues(alpha: 0.5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.alternate_email_rounded, size: 17, color: _ink),
                    SizedBox(width: 6),
                    Text(
                      'CONTACT',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
                        color: _ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  m.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: _ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEducationCarousel(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ACADEMIC DECK',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: _ink,
                letterSpacing: 1,
              ),
            ),
            Text(
              '${_currentEduPage + 1} / ${m.qualifications.length}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: _cobalt,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 155,
          child: PageView.builder(
            controller: _pageController,
            itemCount: m.qualifications.length,
            onPageChanged: (idx) => setState(() => _currentEduPage = idx),
            itemBuilder: (context, index) {
              final q = m.qualifications[index];
              final cardColors = [
                Colors.white,
                const Color(0xFFE0E7FF),
                const Color(0xFFFFE4E6),
                const Color(0xFFD1FAE5),
              ];
              return Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: _brutalBox(
                    color: cardColors[index % cardColors.length],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text(
                              q.level,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: _ink,
                            visualDensity: VisualDensity.compact,
                          ),
                          Text(
                            q.year,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: _cobalt,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        q.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        q.institution,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.5,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsStickerBoard(GroupMember m) {
    final badgeColors = [_coral, _cobalt, _mint, _sun];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _brutalBox(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SOFT SKILLS STICKER PACK',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: _ink,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(m.softSkills.length, (i) {
              final s = m.softSkills[i];
              final color = badgeColors[i % badgeColors.length];
              final isDarkBg = color == _coral || color == _cobalt;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: _ink, width: 2),
                ),
                child: Text(
                  '${s.name} • ${(s.level * 100).round()}%',
                  style: TextStyle(
                    color: isDarkBg ? Colors.white : _ink,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTalentsShowcase(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SPECIAL TALENTS & HOBBIES',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: _ink,
          ),
        ),
        const SizedBox(height: 12),
        ...m.talents.map(
          (t) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: _brutalBox(color: Colors.white),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _coral,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _ink, width: 2),
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${t.title} — ${t.category}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.detail,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF374151),
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
    );
  }
}
