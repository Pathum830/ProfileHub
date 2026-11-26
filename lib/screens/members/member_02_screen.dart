import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 02 BIO SCREEN — Design Style: Professional Business Profile
/// ============================================================================
/// Contributor: Member 02
/// Corporate navy & warm amber executive resume using NestedScrollView,
/// overlapping Stack avatar, TabBarView, and structured Table contact details.
/// ============================================================================
class Member02Screen extends StatefulWidget {
  const Member02Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member02Screen> createState() => _Member02ScreenState();
}

class _Member02ScreenState extends State<Member02Screen> {
  static const Color _navy = Color(0xFF0F2942);
  static const Color _navyLight = Color(0xFF1E3A5F);
  static const Color _gold = Color(0xFFD97706);
  static const Color _bg = Color(0xFFF3F5F8);

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied email: $email'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: _bg,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              expandedHeight: 272,
              pinned: true,
              backgroundColor: _navy,
              foregroundColor: Colors.white,
              title: Text(
                m.fullName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              actions: [
                FavoriteButton(
                  memberId: m.id,
                  activeColor: _gold,
                  inactiveColor: Colors.white,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: _buildCorporateBanner(m),
              ),
              bottom: const TabBar(
                indicatorColor: _gold,
                indicatorWeight: 3,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                tabs: [
                  Tab(icon: Icon(Icons.badge_outlined, size: 18), text: 'Overview'),
                  Tab(icon: Icon(Icons.school_outlined, size: 18), text: 'Academics'),
                  Tab(icon: Icon(Icons.star_outline_rounded, size: 18), text: 'Skills & Talents'),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildOverviewTab(m),
              _buildAcademicsTab(m),
              _buildSkillsAndTalentsTab(m),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCorporateBanner(GroupMember m) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, _navyLight],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 62, 20, 52),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _gold, width: 2.5),
            ),
            child: ClipOval(
              child: Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: _navy,
                  width: 88,
                  height: 88,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: _gold.withValues(alpha: 0.6)),
                  ),
                  child: Text(
                    'EXECUTIVE PROFILE • ${m.studentId}',
                    style: const TextStyle(
                      color: Color(0xFFFDE68A),
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  m.fullName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  m.shortRole,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(GroupMember m) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BizHeader(title: 'Executive Summary'),
                const SizedBox(height: 10),
                Text(
                  m.shortDescription,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: Color(0xFF334155),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    border: Border(left: BorderSide(color: _gold, width: 3.5)),
                  ),
                  child: Text(
                    '"${m.bioQuote}"',
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: _navy,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: _BizHeader(title: 'Contact & Identity Record'),
                    ),
                    TextButton.icon(
                      onPressed: () => _copyEmail(m.email),
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: const Text('Copy Email'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Table(
                  columnWidths: const {
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    _tableRow('Full Name', m.fullName),
                    _tableRow('Address', m.address),
                    _tableRow('Email', m.email),
                    _tableRow('Student ID', m.studentId),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BizHeader(title: 'Snapshot Highlights'),
                const SizedBox(height: 10),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: _navy,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.school_outlined, size: 18),
                  ),
                  title: Text(m.qualifications.last.title),
                  subtitle: Text('${m.qualifications.length} verified qualifications'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: _gold,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.psychology_outlined, size: 18),
                  ),
                  title: Text(m.softSkills.map((s) => s.name).join(' • ')),
                  subtitle: Text('${m.talents.length} special talents & interests'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _tableRow(String label, String value) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              color: Color(0xFF64748B),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13.5,
              color: _navy,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAcademicsTab(GroupMember m) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: m.qualifications.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final q = m.qualifications[index];
        return Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _navy.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                '0${index + 1}',
                style: const TextStyle(
                  color: _navy,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            title: Text(
              q.title,
              style: const TextStyle(fontWeight: FontWeight.w700, color: _navy),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('${q.level} • ${q.institution}\nYear: ${q.year}'),
            ),
            trailing: q.gradeOrStatus != null
                ? Chip(
                    label: Text(
                      q.gradeOrStatus!,
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                    backgroundColor: _gold.withValues(alpha: 0.14),
                  )
                : null,
          ),
        );
      },
    );
  }

  Widget _buildSkillsAndTalentsTab(GroupMember m) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BizHeader(title: 'Core Soft Skills'),
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
                                fontWeight: FontWeight.w700,
                                color: _navy,
                              ),
                            ),
                            Text(
                              '${(s.level * 100).round()}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _gold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: s.level,
                          minHeight: 7,
                          borderRadius: BorderRadius.circular(4),
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(_navy),
                        ),
                        if (s.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            s.description,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BizHeader(title: 'Special Talents & Extracurriculars'),
                const SizedBox(height: 10),
                ...m.talents.map(
                  (t) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.workspace_premium_outlined, color: _gold),
                    title: Text(
                      '${t.title} (${t.category})',
                      style: const TextStyle(fontWeight: FontWeight.w700, color: _navy),
                    ),
                    subtitle: Text(t.detail),
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

class _BizHeader extends StatelessWidget {
  const _BizHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: _Member02ScreenState._gold,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: _Member02ScreenState._navy,
            ),
          ),
        ),
      ],
    );
  }
}
