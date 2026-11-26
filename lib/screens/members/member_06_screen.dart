import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

class Member06Screen extends StatelessWidget {
  const Member06Screen({super.key, required this.member});

  final GroupMember member;

  static const _ink = Color(0xFF151413);
  static const _paper = Color(0xFFFFFFFF);
  static const _muted = Color(0xFF57514D);
  static const _orange = Color(0xFF97502F);
  static const _lightOrange = Color(0xFFDEA487);
  static const _rule = Color(0xFFD9D2CD);
  static const _missing = 'Not provided (placeholder)';

  static const _display = TextStyle(
    color: _ink,
    fontFamily: 'serif',
    fontWeight: FontWeight.w700,
    fontSize: 38,
    height: 1.02,
  );
  static const _label = TextStyle(
    color: _orange,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.7,
  );
  static const _body = TextStyle(color: _muted, fontSize: 15, height: 1.5);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final photo = MemberPhoto(
      assetPath: member.photoAsset,
      memberNumber: member.memberNumber,
      accentColor: _orange,
    );

    return Scaffold(
      backgroundColor: _paper,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: (size.width * 1.18).clamp(280.0, 640.0).toDouble(),
            backgroundColor: _ink,
            foregroundColor: _paper,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'NexaProfile',
              style: TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              FavoriteButton(
                memberId: member.id,
                activeColor: _lightOrange,
                inactiveColor: _paper,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: reduceMotion
                  ? CollapseMode.pin
                  : CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Semantics(
                    image: true,
                    label: 'Portrait of ${member.fullName}',
                    child: HeroMode(
                      enabled: !reduceMotion,
                      child: Hero(tag: 'photo_${member.id}', child: photo),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xDD151413),
                          Color(0x00151413),
                          Color(0xAA151413),
                        ],
                        stops: [0, 0.36, 1],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 20,
                    child: Text(
                      'MEMBER ${member.memberNumber.toString().padLeft(2, '0')}',
                      style: _label.copyWith(color: _paper),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                _spread(
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final titleSize = (constraints.maxWidth * .115)
                          .clamp(28.0, 80.0)
                          .toDouble();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(member.studentId, style: _label),
                          const SizedBox(height: 8),
                          Semantics(
                            header: true,
                            child: Text(
                              member.fullName,
                              style: _display.copyWith(fontSize: titleSize),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(member.shortRole, style: _body),
                          const SizedBox(height: 22),
                          const Divider(color: _ink),
                          const SizedBox(height: 10),
                          Text('ADDRESS', style: _label),
                          SelectableText(member.address, style: _body),
                          const SizedBox(height: 12),
                          Text('EMAIL', style: _label),
                          SelectableText(member.email, style: _body),
                        ],
                      );
                    },
                  ),
                ),
                _spread(_about()),
                _spread(_section('Academic qualifications', _qualifications())),
                ColoredBox(
                  color: _ink,
                  child: _spread(
                    _section('Soft skills', _skills(), color: _paper),
                  ),
                ),
                _spread(_section('Special talents', _talents())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _spread(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 780),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }

  Widget _section(String title, Widget content, {Color color = _ink}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: _display.copyWith(color: color)),
        ),
        const SizedBox(height: 20),
        content,
      ],
    );
  }

  Widget _about() {
    final lead = member.shortDescription.trim();
    final quote = member.bioQuote.trim();
    return _section(
      'About me',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (lead.isEmpty)
            const Text(_missing, style: _body)
          else
            Semantics(
              label: lead,
              child: ExcludeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lead.characters.first,
                      style: _display.copyWith(color: _orange, fontSize: 62),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        lead.characters.skip(1).toString(),
                        style: _body.copyWith(
                          fontFamily: 'serif',
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: _orange, width: 3)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
            child: Text(
              quote.isEmpty ? 'Pull quote · $_missing' : '“$quote”',
              style: _display.copyWith(
                color: _orange,
                fontSize: 27,
                fontStyle: FontStyle.italic,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _qualifications() {
    if (member.qualifications.isEmpty) {
      return const Text(_missing, style: _body);
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 18.0;
        final scale = MediaQuery.textScalerOf(context).scale(15) / 15;
        final columns = constraints.maxWidth >= 288 * scale ? 2 : 1;
        final width = (constraints.maxWidth - (columns - 1) * gap) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final qualification in member.qualifications)
              SizedBox(
                width: width,
                child: _entry(
                  label: qualification.level,
                  title: qualification.title,
                  details: [
                    qualification.institution,
                    qualification.year,
                    ?qualification.gradeOrStatus,
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _skills() {
    if (member.softSkills.isEmpty) {
      return Text(_missing, style: _body.copyWith(color: _paper));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final skill in member.softSkills)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: _lightOrange),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(skill.name, style: _body.copyWith(color: _paper)),
          ),
      ],
    );
  }

  Widget _talents() {
    if (member.talents.isEmpty) {
      return const Text(_missing, style: _body);
    }
    return Column(
      children: [
        for (final talent in member.talents)
          _entry(
            label: talent.category,
            title: talent.title,
            details: [talent.detail],
          ),
      ],
    );
  }

  Widget _entry({
    required String label,
    required String title,
    required List<String> details,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: _rule)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: _label),
          const SizedBox(height: 5),
          Text(title, style: _display.copyWith(fontSize: 23, height: 1.15)),
          const SizedBox(height: 6),
          for (final detail in details) Text(detail, style: _body),
        ],
      ),
    );
  }
}
