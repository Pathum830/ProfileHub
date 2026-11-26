import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

class Member08Screen extends StatefulWidget {
  const Member08Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member08Screen> createState() => _Member08ScreenState();
}

class _Member08ScreenState extends State<Member08Screen> {
  static const _blue = Color(0xFFE1EEFF);
  static const _lavender = Color(0xFFEAE3FC);
  static const _ink = Color(0xFF222745);
  static const _accent = Color(0xFF534386);
  static const _gap = SizedBox(height: 12);
  static const _duration = Duration(milliseconds: 220);

  int? _selectedSkill;
  bool _showEducation = true;
  bool _showInterests = true;

  @override
  Widget build(BuildContext context) {
    final member = widget.member;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FE),
      appBar: AppBar(
        title: const Text('Member 08'),
        foregroundColor: _ink,
        backgroundColor: const Color(0xFFF4F6FE),
        actions: [FavoriteButton(memberId: member.id, activeColor: _accent)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 840),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
                  final portrait = _BentoCard(
                    color: _blue,
                    padding: const EdgeInsets.all(8),
                    child: Hero(
                      tag: 'photo_${member.id}',
                      child: MemberPhoto(
                        assetPath: member.photoAsset,
                        memberNumber: member.memberNumber,
                        accentColor: _accent,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: width >= 340 * scale ? 268 : 200,
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  );
                  final identity = Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _BentoCard(
                        color: _lavender,
                        child: _tile(
                          Icons.person_outline_rounded,
                          member.fullName,
                          member.shortRole,
                          featured: true,
                        ),
                      ),
                      _gap,
                      _BentoCard(
                        child: _tile(
                          Icons.mail_outline_rounded,
                          'Contact',
                          'Email: ${member.email}\nAddress: ${member.address}',
                        ),
                      ),
                    ],
                  );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (width >= 340 * scale)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 4, child: portrait),
                            const SizedBox(width: 12),
                            Expanded(flex: 6, child: identity),
                          ],
                        )
                      else ...[
                        portrait,
                        _gap,
                        identity,
                      ],
                      _gap,
                      _BentoCard(
                        child: _tile(
                          Icons.info_outline_rounded,
                          'About',
                          member.shortDescription,
                        ),
                      ),
                      _gap,
                      _BentoCard(color: _lavender, child: _skills(member)),
                      _gap,
                      _section(
                        'Academic qualifications',
                        _showEducation,
                        () => setState(() => _showEducation = !_showEducation),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: width >= 600 * scale ? 2 : 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 64 + 110 * scale,
                              ),
                          itemCount: member.qualifications.length,
                          itemBuilder: (context, index) {
                            final item = member.qualifications[index];
                            return _BentoCard(
                              color: index.isEven ? _blue : _lavender,
                              child: _tile(
                                Icons.school_outlined,
                                item.title,
                                [
                                  item.institution,
                                  item.year,
                                  if (item.gradeOrStatus != null)
                                    item.gradeOrStatus!,
                                ].join('\n'),
                              ),
                            );
                          },
                        ),
                      ),
                      _gap,
                      _section(
                        'Special talents & hobbies',
                        _showInterests,
                        () => setState(() => _showInterests = !_showInterests),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final item in member.talents)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    width: (width - 32)
                                        .clamp(180.0, 290.0)
                                        .toDouble(),
                                    child: _BentoCard(
                                      color: item.category == 'Hobby'
                                          ? _lavender
                                          : _blue,
                                      child: _tile(
                                        Icons.auto_awesome_outlined,
                                        item.title,
                                        '${item.category}\n${item.detail}',
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _skills(GroupMember member) {
    final index = _selectedSkill;
    final skill = index != null && index < member.softSkills.length
        ? member.softSkills[index]
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heading('Soft skills'),
        _gap,
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            for (var i = 0; i < member.softSkills.length; i++)
              FilterChip(
                label: Text(member.softSkills[i].name),
                selected: index == i,
                selectedColor: _blue,
                backgroundColor: Colors.white,
                onSelected: (selected) =>
                    setState(() => _selectedSkill = selected ? i : null),
              ),
          ],
        ),
        AnimatedSize(
          duration: _duration,
          alignment: Alignment.topLeft,
          child: skill == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: _BentoCard(
                    child: _tile(
                      Icons.check_circle_outline,
                      skill.name,
                      skill.description,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _section(
    String title,
    bool expanded,
    VoidCallback toggle,
    Widget body,
  ) {
    return _BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: toggle,
            style: TextButton.styleFrom(foregroundColor: _ink),
            child: Row(
              children: [
                Expanded(child: _heading(title)),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  semanticLabel: expanded ? 'Collapse' : 'Expand',
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: _duration,
            alignment: Alignment.topCenter,
            child: expanded
                ? Padding(padding: const EdgeInsets.only(top: 8), child: body)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    String detail, {
    bool featured = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 21, color: _accent),
        const SizedBox(height: 7),
        _heading(title, size: featured ? 26 : 16),
        const SizedBox(height: 4),
        Text(
          detail,
          style: const TextStyle(color: _ink, fontSize: 13, height: 1.3),
        ),
      ],
    );
  }

  Widget _heading(String text, {double size = 18}) => Text(
    text,
    style: TextStyle(color: _ink, fontSize: size, fontWeight: FontWeight.w800),
  );
}

class _BentoCard extends StatelessWidget {
  const _BentoCard({
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(14),
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFDBE1F1)),
    ),
    child: child,
  );
}
