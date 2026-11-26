import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 01 BIO SCREEN — Design Style: Modern Minimalist Profile
/// ============================================================================
/// Contributor: Member 01
/// Replace personal data in `lib/data/members_data.dart` and customize this
/// minimalist editorial layout if desired.
/// ============================================================================
class Member01Screen extends StatefulWidget {
  const Member01Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member01Screen> createState() => _Member01ScreenState();
}

class _Member01ScreenState extends State<Member01Screen> {
  static const Color _bg = Color(0xFFFAF9F6);
  static const Color _ink = Color(0xFF1A1A1A);
  static const Color _muted = Color(0xFF6B6B6B);
  static const Color _accent = Color(0xFFC85A32);
  static const Color _line = Color(0xFFE5E2DC);

  String _activeFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: _bg,
            foregroundColor: _ink,
            elevation: 0,
            scrolledUnderElevation: 0.5,
            title: Text(
              '01 — MINIMALIST EDITION',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.2,
                color: _muted,
              ),
            ),
            actions: [
              FavoriteButton(
                memberId: m.id,
                activeColor: _accent,
                inactiveColor: _ink,
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMinimalHero(m),
                      const SizedBox(height: 28),
                      const Divider(color: _line, height: 1),
                      const SizedBox(height: 20),
                      _buildContactStrip(m),
                      const SizedBox(height: 20),
                      const Divider(color: _line, height: 1),
                      const SizedBox(height: 22),
                      _buildFilterRow(),
                      const SizedBox(height: 24),
                      if (_activeFilter == 'All' || _activeFilter == 'Academics')
                        _buildAcademicsSection(m),
                      if (_activeFilter == 'All' || _activeFilter == 'Skills')
                        _buildSkillsSection(m),
                      if (_activeFilter == 'All' || _activeFilter == 'Talents')
                        _buildTalentsSection(m),
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

  Widget _buildMinimalHero(GroupMember m) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 520;
        final photoWidget = Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: -10,
              bottom: -10,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: _accent, width: 1.5),
                ),
              ),
            ),
            Hero(
              tag: 'photo_${m.id}',
              child: MemberPhoto(
                assetPath: m.photoAsset,
                memberNumber: m.memberNumber,
                accentColor: _accent,
                width: wide ? 170 : 140,
                height: wide ? 190 : 160,
              ),
            ),
          ],
        );

        final introColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              m.studentId,
              style: const TextStyle(
                color: _accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              m.fullName,
              style: const TextStyle(
                color: _ink,
                fontSize: 28,
                fontWeight: FontWeight.w300,
                height: 1.15,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              m.shortRole.toUpperCase(),
              style: const TextStyle(
                color: _muted,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              '"${m.bioQuote}"',
              style: const TextStyle(
                color: _ink,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ],
        );

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              photoWidget,
              const SizedBox(width: 32),
              Expanded(child: introColumn),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            photoWidget,
            const SizedBox(height: 26),
            introColumn,
          ],
        );
      },
    );
  }

  Widget _buildContactStrip(GroupMember m) {
    return Wrap(
      spacing: 28,
      runSpacing: 14,
      children: [
        _MinimalMetaItem(
          label: 'LOCATION',
          value: m.address,
          icon: Icons.place_outlined,
        ),
        _MinimalMetaItem(
          label: 'EMAIL',
          value: m.email,
          icon: Icons.mail_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildFilterRow() {
    const filters = ['All', 'Academics', 'Skills', 'Talents'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filters.map((label) {
        final selected = _activeFilter == label;
        return ChoiceChip(
          label: Text(label),
          selected: selected,
          showCheckmark: false,
          selectedColor: _ink,
          backgroundColor: Colors.transparent,
          side: BorderSide(color: selected ? _ink : _line),
          labelStyle: TextStyle(
            color: selected ? _bg : _ink,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
          ),
          onSelected: (_) => setState(() => _activeFilter = label),
        );
      }).toList(),
    );
  }

  Widget _buildAcademicsSection(GroupMember m) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(number: '01', title: 'ACADEMIC QUALIFICATIONS'),
          const SizedBox(height: 14),
          ...m.qualifications.map(
            (q) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.only(bottom: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _line)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 82,
                    child: Text(
                      q.year,
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${q.level} — ${q.title}',
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          q.gradeOrStatus != null
                              ? '${q.institution} • ${q.gradeOrStatus}'
                              : q.institution,
                          style: const TextStyle(color: _muted, fontSize: 13),
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
  }

  Widget _buildSkillsSection(GroupMember m) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionHeading(number: '02', title: 'SOFT SKILLS'),
          const SizedBox(height: 14),
          ...m.softSkills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(s.level * 100).round()}%',
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: s.level,
                      minHeight: 3,
                      backgroundColor: _line,
                      valueColor: const AlwaysStoppedAnimation<Color>(_ink),
                    ),
                  ),
                  if (s.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      s.description,
                      style: const TextStyle(color: _muted, fontSize: 12.5),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTalentsSection(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeading(number: '03', title: 'SPECIAL TALENTS & HOBBIES'),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: m.talents.map((t) {
            return Container(
              width: 215,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.category.toUpperCase(),
                    style: const TextStyle(
                      color: _accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    t.title,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.detail,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: _Member01ScreenState._accent,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _Member01ScreenState._ink,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _MinimalMetaItem extends StatelessWidget {
  const _MinimalMetaItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: _Member01ScreenState._accent),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _Member01ScreenState._muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: _Member01ScreenState._ink,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
