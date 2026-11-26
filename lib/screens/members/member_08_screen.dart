import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 08 BIO SCREEN — Design Style: Card-Based (Bento Grid) Profile
/// ============================================================================
/// Contributor: Member 08
/// Soft mint & warm amber Material 3 Bento-box layout featuring modular
/// rounded cards, AnimatedSize expandable story, interactive FilterChip skills,
/// and horizontal hobby cards.
/// ============================================================================
class Member08Screen extends StatefulWidget {
  const Member08Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member08Screen> createState() => _Member08ScreenState();
}

class _Member08ScreenState extends State<Member08Screen> {
  static const Color _bg = Color(0xFFEEF4F2);
  static const Color _teal = Color(0xFF0D9488);
  static const Color _amber = Color(0xFFF59E0B);
  static const Color _ink = Color(0xFF132A26);

  bool _expandQuote = false;
  int _selectedSkillIndex = 0;

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final selectedSkill = m.softSkills[_selectedSkillIndex.clamp(0, m.softSkills.length - 1)];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: _ink,
        elevation: 0,
        title: const Text(
          'Bento Profile • 08',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          FavoriteButton(
            memberId: m.id,
            activeColor: _teal,
            inactiveColor: _ink,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeroBentoCard(m),
                const SizedBox(height: 14),
                _buildContactBentoPair(m),
                const SizedBox(height: 14),
                _buildInteractiveSkillsBento(m, selectedSkill),
                const SizedBox(height: 14),
                _buildQualificationsBento(m),
                const SizedBox(height: 14),
                _buildTalentsBentoRow(m),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBentoCard(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: _teal.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: _teal,
                  width: 92,
                  height: 92,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _teal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${m.shortRole} • ${m.studentId}',
                        style: const TextStyle(
                          color: _teal,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      m.fullName,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      m.shortDescription,
                      style: const TextStyle(
                        color: Color(0xFF4B635E),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedSize(
            duration: const Duration(milliseconds: 240),
            child: _expandQuote
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDFA),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '"${m.bioQuote}"',
                      style: const TextStyle(
                        color: _teal,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => setState(() => _expandQuote = !_expandQuote),
              icon: Icon(
                _expandQuote ? Icons.expand_less : Icons.format_quote_rounded,
                size: 18,
              ),
              label: Text(_expandQuote ? 'Hide Motto' : 'Show Personal Motto'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactBentoPair(GroupMember m) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 480;
        final locationCard = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _teal,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: const Icon(Icons.location_on_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(color: Colors.white70, fontSize: 11.5),
                    ),
                    Text(
                      m.address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        final emailCard = Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFEF3C7),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: _amber.withValues(alpha: 0.25),
                child: const Icon(Icons.alternate_email_rounded, color: Color(0xFF92400E)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email Address',
                      style: TextStyle(color: Color(0xFF92400E), fontSize: 11.5),
                    ),
                    Text(
                      m.email,
                      style: const TextStyle(
                        color: Color(0xFF78350F),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        if (wide) {
          return Row(
            children: [
              Expanded(child: locationCard),
              const SizedBox(width: 12),
              Expanded(child: emailCard),
            ],
          );
        }

        return Column(
          children: [
            locationCard,
            const SizedBox(height: 12),
            emailCard,
          ],
        );
      },
    );
  }

  Widget _buildInteractiveSkillsBento(GroupMember m, SoftSkill selectedSkill) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Soft Skills',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(m.softSkills.length, (i) {
              final s = m.softSkills[i];
              final selected = i == _selectedSkillIndex;
              return FilterChip(
                selected: selected,
                label: Text(s.name),
                selectedColor: _teal,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : _ink,
                  fontWeight: FontWeight.w600,
                ),
                onSelected: (_) => setState(() => _selectedSkillIndex = i),
              );
            }),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        selectedSkill.name,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(selectedSkill.level * 100).round()}% Strength',
                      style: const TextStyle(
                        color: _teal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  selectedSkill.description,
                  style: const TextStyle(color: Color(0xFF4B635E), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualificationsBento(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Academic Qualifications',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = constraints.maxWidth >= 500 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: m.qualifications.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 118,
                ),
                itemBuilder: (context, index) {
                  final q = m.qualifications[index];
                  return Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              q.level,
                              style: const TextStyle(
                                color: _teal,
                                fontWeight: FontWeight.w800,
                                fontSize: 11.5,
                              ),
                            ),
                            Text(
                              q.year,
                              style: const TextStyle(
                                color: _amber,
                                fontWeight: FontWeight.w800,
                                fontSize: 11.5,
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
                            color: _ink,
                            fontWeight: FontWeight.w700,
                            fontSize: 13.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          q.institution,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 11.5,
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

  Widget _buildTalentsBentoRow(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Special Talents & Hobbies',
            style: TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 142,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: m.talents.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final t = m.talents[index];
              return Container(
                width: 225,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: _amber.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.stars_rounded, size: 16, color: _amber),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.category,
                          style: const TextStyle(
                            color: _teal,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      t.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      t.detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
