import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 04 BIO SCREEN — Design Style: Gradient & Glassmorphic Profile Design
/// ============================================================================
/// Contributor: Member 04
/// Multi-layered aurora gradients with frosted BackdropFilter glass cards,
/// glowing orb accents, horizontal academics gallery, and ExpansionTile panels.
/// ============================================================================
class Member04Screen extends StatefulWidget {
  const Member04Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member04Screen> createState() => _Member04ScreenState();
}

class _Member04ScreenState extends State<Member04Screen> {
  int _gradientThemeIndex = 0;

  static const List<List<Color>> _palettes = [
    [Color(0xFF1E1B4B), Color(0xFF5B21B6), Color(0xFFBE185D)],
    [Color(0xFF0F172A), Color(0xFF0E7490), Color(0xFF4F46E5)],
    [Color(0xFF311042), Color(0xFF7E22CE), Color(0xFFEC4899)],
  ];

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final colors = _palettes[_gradientThemeIndex];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Aurora Glass • M04',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Shift gradient aura',
            onPressed: () {
              setState(() {
                _gradientThemeIndex = (_gradientThemeIndex + 1) % _palettes.length;
              });
            },
            icon: const Icon(Icons.palette_outlined),
          ),
          FavoriteButton(
            memberId: m.id,
            activeColor: const Color(0xFFF472B6),
            inactiveColor: Colors.white,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -30,
            child: _GlowOrb(color: Colors.pinkAccent.withValues(alpha: 0.35), size: 220),
          ),
          Positioned(
            bottom: 80,
            left: -50,
            child: _GlowOrb(color: Colors.cyanAccent.withValues(alpha: 0.25), size: 240),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildGlassHero(m),
                      const SizedBox(height: 16),
                      _buildContactGlass(m),
                      const SizedBox(height: 20),
                      const Text(
                        'Academic Journey',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildHorizontalAcademics(m),
                      const SizedBox(height: 20),
                      _buildGlassExpansion(
                        title: 'Soft Skills (${m.softSkills.length})',
                        icon: Icons.psychology_alt_outlined,
                        initiallyExpanded: true,
                        children: m.softSkills
                            .map(
                              (s) => ListTile(
                                dense: true,
                                leading: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                                  child: Text(
                                    '${(s.level * 100).round()}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  s.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  s.description,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 14),
                      _buildGlassExpansion(
                        title: 'Special Talents & Hobbies (${m.talents.length})',
                        icon: Icons.music_note_outlined,
                        initiallyExpanded: true,
                        children: m.talents
                            .map(
                              (t) => ListTile(
                                dense: true,
                                leading: const Icon(
                                  Icons.auto_awesome_rounded,
                                  color: Color(0xFFFDE68A),
                                ),
                                title: Text(
                                  '${t.title} • ${t.category}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  t.detail,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
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
  }

  Widget _buildGlassHero(GroupMember m) {
    return _GlassPanel(
      padding: const EdgeInsets.all(22),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF38BDF8),
                  Color(0xFFF472B6),
                  Color(0xFFA78BFA),
                  Color(0xFF38BDF8),
                ],
              ),
            ),
            child: ClipOval(
              child: Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: const Color(0xFF7C3AED),
                  width: 112,
                  height: 112,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            m.fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${m.shortRole} • ${m.studentId}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            m.bioQuote,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontStyle: FontStyle.italic,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactGlass(GroupMember m) {
    return _GlassPanel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white70, size: 19),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  m.address,
                  style: const TextStyle(color: Colors.white, fontSize: 13.5),
                ),
              ),
            ],
          ),
          Divider(color: Colors.white.withValues(alpha: 0.18), height: 20),
          Row(
            children: [
              const Icon(Icons.email_outlined, color: Colors.white70, size: 19),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  m.email,
                  style: const TextStyle(color: Colors.white, fontSize: 13.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalAcademics(GroupMember m) {
    return SizedBox(
      height: 148,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: m.qualifications.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final q = m.qualifications[index];
          return SizedBox(
            width: 235,
            child: _GlassPanel(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          q.level,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        q.year,
                        style: const TextStyle(
                          color: Color(0xFFFDE68A),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
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
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    q.institution,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGlassExpansion({
    required String title,
    required IconData icon,
    required bool initiallyExpanded,
    required List<Widget> children,
  }) {
    return _GlassPanel(
      padding: EdgeInsets.zero,
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            iconColor: Colors.white,
            collapsedIconColor: Colors.white70,
            leading: Icon(icon, color: Colors.white),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            children: children,
          ),
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({required this.child, required this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0.0)],
        ),
      ),
    );
  }
}
