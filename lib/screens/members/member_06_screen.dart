import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 06 BIO SCREEN — Design Style: Magazine-Style Profile
/// ============================================================================
/// Contributor: Member 06
/// High-contrast print editorial spread featuring a full-bleed cover hero,
/// oversized pull-quote, drop-cap intro, inverted feature box, and 2-column grid.
/// ============================================================================
class Member06Screen extends StatefulWidget {
  const Member06Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member06Screen> createState() => _Member06ScreenState();
}

class _Member06ScreenState extends State<Member06Screen> {
  static const Color _paper = Color(0xFFFFFFFF);
  static const Color _jet = Color(0xFF111111);
  static const Color _crimson = Color(0xFFB91C1C);
  static const Color _stone = Color(0xFF57534E);

  bool _showEditionNotes = false;

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return Scaffold(
      backgroundColor: _paper,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 330,
            pinned: true,
            backgroundColor: _jet,
            foregroundColor: Colors.white,
            title: const Text(
              'THE CA02 REVIEW',
              style: TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.w700,
                letterSpacing: 2.0,
                fontSize: 15,
              ),
            ),
            actions: [
              FavoriteButton(
                memberId: m.id,
                activeColor: _crimson,
                inactiveColor: Colors.white,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'photo_${m.id}',
                    child: MemberPhoto(
                      assetPath: m.photoAsset,
                      memberNumber: m.memberNumber,
                      accentColor: _crimson,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: _crimson,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Text(
                            'ISSUE NO. 06  •  ${m.shortRole.toUpperCase()}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          m.fullName,
                          style: const TextStyle(
                            fontFamily: 'serif',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1.08,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${m.address}  |  ${m.studentId}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 740),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPullQuote(m),
                      const SizedBox(height: 22),
                      _buildDropCapLead(m),
                      const SizedBox(height: 24),
                      _buildEditorialColumns(m),
                      const SizedBox(height: 24),
                      _buildInvertedSkillsSpread(m),
                      const SizedBox(height: 24),
                      _buildCultureAndTalents(m),
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

  Widget _buildPullQuote(GroupMember m) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: _jet, width: 2.5),
          bottom: BorderSide(color: _jet, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '“',
            style: TextStyle(
              fontFamily: 'serif',
              color: _crimson,
              fontSize: 48,
              height: 0.85,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              m.bioQuote,
              style: const TextStyle(
                fontFamily: 'serif',
                color: _jet,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropCapLead(GroupMember m) {
    final firstChar = m.shortDescription.isNotEmpty
        ? m.shortDescription[0].toUpperCase()
        : 'G';
    final rest = m.shortDescription.length > 1
        ? m.shortDescription.substring(1)
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, top: 2),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              color: _jet,
              child: Text(
                firstChar,
                style: const TextStyle(
                  fontFamily: 'serif',
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                rest,
                style: const TextStyle(
                  fontFamily: 'serif',
                  color: _jet,
                  fontSize: 15.5,
                  height: 1.55,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () => setState(() => _showEditionNotes = !_showEditionNotes),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _showEditionNotes ? 'HIDE MASTHEAD DETAILS' : 'VIEW MASTHEAD CONTACT',
                style: const TextStyle(
                  color: _crimson,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                _showEditionNotes
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: _crimson,
                size: 18,
              ),
            ],
          ),
        ),
        if (_showEditionNotes) ...[
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFFF5F5F4),
            child: Text(
              'Correspondent Email: ${m.email}\nEditorial Bureau: ${m.address}',
              style: const TextStyle(color: _jet, fontSize: 13, height: 1.5),
            ),
          ),
        ] else ...[
          const SizedBox(height: 6),
          Text(
            'Contact: ${m.email}  •  ${m.address}',
            style: const TextStyle(color: _stone, fontSize: 12.5),
          ),
        ],
      ],
    );
  }

  Widget _buildEditorialColumns(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ACADEMIC CREDENTIALS',
          style: TextStyle(
            color: _crimson,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossCount = constraints.maxWidth >= 520 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: m.qualifications.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                mainAxisSpacing: 12,
                crossAxisSpacing: 14,
                childAspectRatio: crossCount == 2 ? 2.15 : 3.2,
              ),
              itemBuilder: (context, index) {
                final q = m.qualifications[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: _jet, width: 1.5),
                      bottom: BorderSide(color: Color(0xFFD6D3D1)),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${q.level.toUpperCase()} — ${q.year}',
                        style: const TextStyle(
                          color: _crimson,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        q.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'serif',
                          color: _jet,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        q.institution,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _stone, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildInvertedSkillsSpread(GroupMember m) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: _jet,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'IN PROFILE: SOFT SKILLS',
            style: TextStyle(
              color: Color(0xFFFCA5A5),
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 14),
          ...m.softSkills.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '▪ ',
                    style: const TextStyle(color: _crimson, fontSize: 16),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 13.5, height: 1.45),
                        children: [
                          TextSpan(
                            text: '${s.name} (${(s.level * 100).round()}%): ',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          TextSpan(
                            text: s.description,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
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

  Widget _buildCultureAndTalents(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ARTS, SPORTS & OFF-THE-CLOCK',
          style: TextStyle(
            color: _crimson,
            fontSize: 12,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 12),
        ...m.talents.map(
          (t) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 44,
                  color: _crimson,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${t.title}  ·  ${t.category.toUpperCase()}',
                        style: const TextStyle(
                          fontFamily: 'serif',
                          color: _jet,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.detail,
                        style: const TextStyle(color: _stone, fontSize: 13),
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
