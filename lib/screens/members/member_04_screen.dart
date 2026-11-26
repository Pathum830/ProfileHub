import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';

/// MEMBER 04 BIO SCREEN — Design Style: Gradient Glassmorphism
/// ============================================================================
/// Contributor: Member 04 (Vichakshi Shashiprabha)
/// Features a purple, blue, and cyan aurora gradient background, blurred glowing
/// backdrop elements, frosted ClipRRect + BackdropFilter glass cards, a large
/// portrait photograph, floating personal info cards, horizontal academic
/// qualification cards, animated soft-skill indicators, and expandable
/// ExpansionTile talent/hobby panels.
/// ============================================================================
class Member04Screen extends StatefulWidget {
  const Member04Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member04Screen> createState() => _Member04ScreenState();
}

class _Member04ScreenState extends State<Member04Screen>
    with SingleTickerProviderStateMixin {
  int _paletteIndex = 0;
  late final AnimationController _entranceController;

  static const List<List<Color>> _auraPalettes = [
    [
      Color(0xFF2E1065),
      Color(0xFF4C1D95),
      Color(0xFF1D4ED8),
      Color(0xFF0891B2),
    ],
    [
      Color(0xFF1E1B4B),
      Color(0xFF3730A3),
      Color(0xFF0284C7),
      Color(0xFF06B6D4),
    ],
    [
      Color(0xFF3B0764),
      Color(0xFF6D28D9),
      Color(0xFF2563EB),
      Color(0xFF0E7490),
    ],
  ];

  static const Color _cyanGlow = Color(0xFF22D3EE);
  static const Color _blueGlow = Color(0xFF3B82F6);
  static const Color _purpleGlow = Color(0xFFA855F7);

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  void _cycleAuraPalette() {
    setState(() {
      _paletteIndex = (_paletteIndex + 1) % _auraPalettes.length;
    });
  }

  void _copyEmail(String email) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied email: $email'),
        backgroundColor: const Color(0xFF1E1B4B),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  void _showQualificationDetails(AcademicQualification qualification) {
    showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: _GlassCard(
          borderRadius: 24,
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _GradientPill(label: qualification.level),
                  Text(
                    qualification.year,
                    style: const TextStyle(
                      color: _cyanGlow,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                qualification.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_rounded,
                    size: 16,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      qualification.institution,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              if (qualification.gradeOrStatus != null &&
                  qualification.gradeOrStatus!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _cyanGlow.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _cyanGlow.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    'Status / Grade: ${qualification.gradeOrStatus}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(foregroundColor: _cyanGlow),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 390;
    final horizontalPadding = screenWidth >= 640
        ? 28.0
        : isCompact
            ? 14.0
            : 18.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildGlassAppBar(m),
      body: Stack(
        children: [
          // Multi-stop purple, blue & cyan gradient canvas
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 550),
              curve: Curves.easeOutCubic,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _auraPalettes[_paletteIndex],
                ),
              ),
            ),
          ),

          // Blurred glowing backdrop orbs refracted by the glass panels
          const Positioned(
            top: -50,
            right: -45,
            child: _BlurredOrb(
              size: 260,
              color: Color(0xAA22D3EE),
            ),
          ),
          const Positioned(
            top: 240,
            left: -70,
            child: _BlurredOrb(
              size: 250,
              color: Color(0xAA8B5CF6),
            ),
          ),
          const Positioned(
            bottom: 180,
            right: -60,
            child: _BlurredOrb(
              size: 240,
              color: Color(0x993B82F6),
            ),
          ),
          const Positioned(
            bottom: -70,
            left: 40,
            child: _BlurredOrb(
              size: 260,
              color: Color(0x9906B6D4),
            ),
          ),

          // Main scrollable glassmorphic content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                36,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 740),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _StaggeredReveal(
                        controller: _entranceController,
                        start: 0.0,
                        end: 0.45,
                        child: _buildHeroGlassCard(m, isCompact),
                      ),
                      const SizedBox(height: 18),
                      _StaggeredReveal(
                        controller: _entranceController,
                        start: 0.12,
                        end: 0.58,
                        child: _buildFloatingPersonalInfo(m),
                      ),
                      const SizedBox(height: 24),
                      _StaggeredReveal(
                        controller: _entranceController,
                        start: 0.24,
                        end: 0.72,
                        child: _buildAcademicsSection(m, isCompact),
                      ),
                      const SizedBox(height: 24),
                      _StaggeredReveal(
                        controller: _entranceController,
                        start: 0.36,
                        end: 0.85,
                        child: _buildSoftSkillsSection(m),
                      ),
                      const SizedBox(height: 24),
                      _StaggeredReveal(
                        controller: _entranceController,
                        start: 0.48,
                        end: 1.0,
                        child: _buildTalentsSection(m),
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

  PreferredSizeWidget _buildGlassAppBar(GroupMember m) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 8,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Text(
              'Member ${m.memberNumber.toString().padLeft(2, '0')} • Glass Bio',
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Shift gradient aura',
          onPressed: _cycleAuraPalette,
          icon: const Icon(Icons.auto_awesome_rounded),
        ),
        FavoriteButton(
          memberId: m.id,
          activeColor: _cyanGlow,
          inactiveColor: Colors.white,
        ),
        const SizedBox(width: 6),
      ],
    );
  }

  Widget _buildHeroGlassCard(GroupMember m, bool isCompact) {
    final photoWidth = isCompact ? 156.0 : 184.0;
    final photoHeight = isCompact ? 198.0 : 234.0;

    return _GlassCard(
      borderRadius: 28,
      padding: EdgeInsets.all(isCompact ? 18 : 24),
      child: Column(
        children: [
          // Large framed portrait photograph with glowing purple-blue-cyan border
          Container(
            padding: const EdgeInsets.all(3.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [_cyanGlow, _blueGlow, _purpleGlow],
              ),
              boxShadow: [
                BoxShadow(
                  color: _cyanGlow.withValues(alpha: 0.28),
                  blurRadius: 26,
                  spreadRadius: 1,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: _purpleGlow.withValues(alpha: 0.25),
                  blurRadius: 28,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.5),
              child: Hero(
                tag: 'photo_${m.id}',
                child: MemberPhoto(
                  assetPath: m.photoAsset,
                  memberNumber: m.memberNumber,
                  accentColor: m.accentColor,
                  width: photoWidth,
                  height: photoHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Style & Member Badge
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _GradientPill(label: m.designStyleName),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.26),
                  ),
                ),
                child: Text(
                  m.studentId,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Full Name & Role
          Text(
            m.fullName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isCompact ? 23 : 27,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            m.shortRole,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _cyanGlow,
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 14),

          // Short Bio Summary
          Text(
            m.shortDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),

          // Floating inner quote box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _cyanGlow.withValues(alpha: 0.28),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote_rounded,
                  color: _cyanGlow,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    m.bioQuote,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.94),
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingPersonalInfo(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionHeader(
          icon: Icons.person_pin_circle_rounded,
          title: 'Personal Information',
          subtitle: 'Floating contact & identity cards',
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final useTwoColumns = constraints.maxWidth >= 520;
            final locationCard = _FloatingInfoCard(
              icon: Icons.location_on_rounded,
              label: 'Location',
              value: m.address,
              accentColors: const [_purpleGlow, _blueGlow],
            );
            final emailCard = _FloatingInfoCard(
              icon: Icons.email_rounded,
              label: 'Email (Tap to copy)',
              value: m.email,
              accentColors: const [_blueGlow, _cyanGlow],
              trailingIcon: Icons.copy_rounded,
              onTap: () => _copyEmail(m.email),
            );

            if (useTwoColumns) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: locationCard),
                  const SizedBox(width: 12),
                  Expanded(child: emailCard),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                locationCard,
                const SizedBox(height: 12),
                emailCard,
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildAcademicsSection(GroupMember m, bool isCompact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          icon: Icons.school_rounded,
          title: 'Academic Qualifications',
          subtitle: 'Swipe horizontally • Tap card for details',
          trailingText: '${m.qualifications.length} items',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: isCompact ? 194 : 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: m.qualifications.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final q = m.qualifications[index];
              return _AcademicQualificationCard(
                qualification: q,
                width: isCompact ? 250 : 272,
                onTap: () => _showQualificationDetails(q),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSoftSkillsSection(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          icon: Icons.psychology_alt_rounded,
          title: 'Soft Skills',
          subtitle: 'Core interpersonal & leadership strengths',
          trailingText: '${m.softSkills.length} skills',
        ),
        const SizedBox(height: 12),
        _GlassCard(
          borderRadius: 24,
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (int i = 0; i < m.softSkills.length; i++) ...[
                _SoftSkillTile(
                  skill: m.softSkills[i],
                  delayIndex: i,
                ),
                if (i < m.softSkills.length - 1)
                  Divider(
                    color: Colors.white.withValues(alpha: 0.14),
                    height: 24,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTalentsSection(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionHeader(
          icon: Icons.stars_rounded,
          title: 'Special Talents & Hobbies',
          subtitle: 'Tap to expand achievements & interests',
          trailingText: '${m.talents.length} areas',
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < m.talents.length; i++) ...[
          _TalentExpansionCard(
            talent: m.talents[i],
            initiallyExpanded: i == 0,
          ),
          if (i < m.talents.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }
}

/// Frosted glass container built with [ClipRRect] and [BackdropFilter].
class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 22,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.20),
                Colors.white.withValues(alpha: 0.08),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// Softly blurred glowing circular orb for the gradient backdrop.
class _BlurredOrb extends StatelessWidget {
  const _BlurredOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 42, sigmaY: 42),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color,
                color.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientPill extends StatelessWidget {
  const _GradientPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C3AED), Color(0xFF2563EB), Color(0xFF06B6D4)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF22D3EE).withValues(alpha: 0.28),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailingText,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.74),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (trailingText != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
            ),
            child: Text(
              trailingText!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class _FloatingInfoCard extends StatelessWidget {
  const _FloatingInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColors,
    this.trailingIcon,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final List<Color> accentColors;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      borderRadius: 20,
      padding: EdgeInsets.zero,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: accentColors,
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.72),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailingIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    trailingIcon,
                    size: 17,
                    color: const Color(0xFF22D3EE),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AcademicQualificationCard extends StatelessWidget {
  const _AcademicQualificationCard({
    required this.qualification,
    required this.width,
    required this.onTap,
  });

  final AcademicQualification qualification;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: _GlassCard(
        borderRadius: 22,
        padding: EdgeInsets.zero,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _GradientPill(label: qualification.level),
                      Flexible(
                        child: Text(
                          qualification.year,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF22D3EE),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    qualification.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14.5,
                      height: 1.28,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_outlined,
                        size: 14,
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          qualification.institution,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.82),
                            fontSize: 12.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (qualification.gradeOrStatus != null &&
                      qualification.gradeOrStatus!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.22),
                        ),
                      ),
                      child: Text(
                        qualification.gradeOrStatus!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftSkillTile extends StatelessWidget {
  const _SoftSkillTile({
    required this.skill,
    required this.delayIndex,
  });

  final SoftSkill skill;
  final int delayIndex;

  @override
  Widget build(BuildContext context) {
    final target = skill.level.clamp(0.0, 1.0);
    final duration = Duration(milliseconds: 650 + (delayIndex * 110));

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: target),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        final percent = (value * 100).round();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular glowing indicator
            SizedBox(
              width: 46,
              height: 46,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: value,
                    strokeWidth: 4.5,
                    backgroundColor: Colors.white.withValues(alpha: 0.16),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF22D3EE),
                    ),
                  ),
                  Text(
                    '$percent%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          skill.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$percent%',
                        style: const TextStyle(
                          color: Color(0xFF22D3EE),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  // Linear gradient progress bar
                  Container(
                    height: 7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFA855F7),
                              Color(0xFF3B82F6),
                              Color(0xFF22D3EE),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF22D3EE)
                                  .withValues(alpha: 0.45),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (skill.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      skill.description,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.78),
                        fontSize: 12.2,
                        height: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TalentExpansionCard extends StatelessWidget {
  const _TalentExpansionCard({
    required this.talent,
    required this.initiallyExpanded,
  });

  final SpecialTalent talent;
  final bool initiallyExpanded;

  IconData _iconForCategory(String category) {
    final normalized = category.toLowerCase();
    if (normalized.contains('sport') || normalized.contains('karate')) {
      return Icons.sports_martial_arts_rounded;
    }
    if (normalized.contains('design') || normalized.contains('art')) {
      return Icons.palette_rounded;
    }
    if (normalized.contains('tech')) {
      return Icons.code_rounded;
    }
    if (normalized.contains('leader')) {
      return Icons.workspace_premium_rounded;
    }
    return Icons.auto_awesome_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      borderRadius: 20,
      padding: EdgeInsets.zero,
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: initiallyExpanded,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            iconColor: const Color(0xFF22D3EE),
            collapsedIconColor: Colors.white70,
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF7C3AED), Color(0xFF06B6D4)],
                ),
              ),
              child: Icon(
                _iconForCategory(talent.category),
                color: Colors.white,
                size: 21,
              ),
            ),
            title: Text(
              talent.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 2.5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22D3EE).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF22D3EE).withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    talent.category,
                    style: const TextStyle(
                      color: Color(0xFFCCFBF1),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                child: Text(
                  talent.detail,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.90),
                    fontSize: 13,
                    height: 1.48,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Smooth staggered fade + upward slide entrance animation.
class _StaggeredReveal extends StatelessWidget {
  const _StaggeredReveal({
    required this.controller,
    required this.start,
    required this.end,
    required this.child,
  });

  final AnimationController controller;
  final double start;
  final double end;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final curve = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}
