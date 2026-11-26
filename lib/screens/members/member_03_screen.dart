import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';
import 'package:provider/provider.dart';

/// ============================================================================
/// MEMBER 03 BIO SCREEN — Design Style: Creative Portfolio / Neo-Brutalist
/// ============================================================================
/// Contributor: Member 03 — Nimeshika Sewwandi
///
/// Neo-Brutalist studio aesthetic with:
/// - Vibrant Yellow, Cyber Purple, Hot Pink, and Jet Black palette.
/// - Rotated Polaroid-style profile photograph with textured washi-tape corners.
/// - Bold typography, playful sticker badges, and tactile drop shadows.
/// - Creative "Dossier / About Me" narrative blueprint.
/// - Interactive PageView Academic Deck carousel with expanded details.
/// - Categorized colourful vinyl sticker tags for technical & soft skills.
/// - Interactive PageView showcase for real resume projects (SentinelCare, etc.).
/// - Illustrated special talents & hobbies with live cheers/applause counters.
/// ============================================================================
class Member03Screen extends StatefulWidget {
  const Member03Screen({super.key, required this.member});

  final GroupMember member;

  @override
  State<Member03Screen> createState() => _Member03ScreenState();
}

class _Member03ScreenState extends State<Member03Screen>
    with SingleTickerProviderStateMixin {
  // Neo-Brutalist Color Palette (Yellow, Purple, Pink, Black)
  static const Color _bgCanvas = Color(0xFFFBF8EF);
  static const Color _ink = Color(0xFF121212);
  static const Color _yellow = Color(0xFFFFDF00);
  static const Color _yellowLight = Color(0xFFFFF7B8);
  static const Color _purple = Color(0xFF8B5CF6);
  static const Color _purpleDark = Color(0xFF6D28D9);
  static const Color _purpleSoft = Color(0xFFEDE9FE);
  static const Color _pink = Color(0xFFFF2A85);
  static const Color _pinkSoft = Color(0xFFFFE0ED);
  static const Color _mint = Color(0xFF00E599);
  static const Color _orange = Color(0xFFFF6B35);

  late final ScrollController _scrollController;
  late final AnimationController _entranceController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  late final PageController _eduPageController;
  int _currentEduPage = 0;

  late final PageController _projectPageController;
  int _currentProjectPage = 0;

  double _polaroidAngle = -0.04;
  String _selectedSkillTab = 'All';
  bool _showSoftSkillBars = true;
  final Map<String, int> _talentCheers = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _eduPageController = PageController(viewportFraction: 0.90);
    _projectPageController = PageController(viewportFraction: 0.92);

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: Curves.easeOutCubic,
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _eduPageController.dispose();
    _projectPageController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _togglePolaroidTilt() {
    HapticFeedback.lightImpact();
    setState(() {
      _polaroidAngle = (_polaroidAngle < 0) ? 0.04 : -0.04;
    });
  }

  void _copyToClipboard(String label, String text) {
    HapticFeedback.mediumImpact();
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: _ink,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: _yellow, width: 2),
        ),
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: _yellow, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Copied $label: $text',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cheerTalent(String talentTitle) {
    HapticFeedback.selectionClick();
    setState(() {
      _talentCheers[talentTitle] = (_talentCheers[talentTitle] ?? 0) + 1;
    });
  }

  // Neo-Brutalist Box helper
  BoxDecoration _neoBox({
    Color color = Colors.white,
    double radius = 16,
    double borderWidth = 2.5,
    Offset shadowOffset = const Offset(4, 4),
    Color shadowColor = _ink,
    Border? customBorder,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: customBorder ?? Border.all(color: _ink, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: shadowColor,
          offset: shadowOffset,
          blurRadius: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.member;
    final memberProvider = context.watch<MemberProvider>();
    final applauseCount = memberProvider.endorsementCount(m.id);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 380;
    final horizontalPadding = screenWidth >= 640 ? 28.0 : (isCompact ? 14.0 : 18.0);

    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildNeoAppBar(context, m),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              18,
              horizontalPadding,
              40,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 820),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Polaroid Hero & Bio Introduction
                    _buildPolaroidHeroSection(m, applauseCount, memberProvider, screenWidth),
                    const SizedBox(height: 24),

                    // 2. Interactive Contact & Social Sticker Bar
                    _buildContactStickerBar(m),
                    const SizedBox(height: 26),

                    // 3. Creative About Me Dossier / Blueprint
                    _buildCreativeAboutMe(m),
                    const SizedBox(height: 28),

                    // 4. Academic Deck Carousel (Interactive PageView)
                    _buildAcademicDeck(m),
                    const SizedBox(height: 28),

                    // 5. Skills Sticker Board (Categorized colourful tags)
                    _buildSkillsArsenal(m),
                    const SizedBox(height: 28),

                    // 6. Featured Real-World Projects Deck (PageView)
                    _buildFeaturedProjectsDeck(),
                    const SizedBox(height: 28),

                    // 7. Illustrated Special Talents & Hobbies Showcase
                    _buildTalentsShowcase(m),
                    const SizedBox(height: 32),

                    // 8. Neo-Brutalist Footer & Directory Button
                    _buildNeoFooter(m),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 0. NEO-BRUTALIST APP BAR
  // ===========================================================================
  PreferredSizeWidget _buildNeoAppBar(BuildContext context, GroupMember m) {
    return AppBar(
      backgroundColor: _yellow,
      foregroundColor: _ink,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 64,
      shape: const Border(
        bottom: BorderSide(color: _ink, width: 3),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: _neoBox(
            color: Colors.white,
            radius: 10,
            borderWidth: 2,
            shadowOffset: const Offset(2, 2),
          ),
          child: const BackButton(color: _ink),
        ),
      ),
      title: const FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'STUDIO // M-03',
          style: TextStyle(
            color: _ink,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 0.8,
          ),
        ),
      ),
      actions: [
        // Copy summary action
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: () => _copyToClipboard('Bio Link', 'https://github.com/Pathum830/ProfileHub'),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: _neoBox(
                color: Colors.white,
                radius: 10,
                borderWidth: 2,
                shadowOffset: const Offset(2, 2),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.share_outlined, size: 15, color: _ink),
                  SizedBox(width: 4),
                  Text(
                    'SHARE',
                    style: TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Synced Favorite Button
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
          child: Container(
            decoration: _neoBox(
              color: Colors.white,
              radius: 10,
              borderWidth: 2,
              shadowOffset: const Offset(2, 2),
            ),
            child: FavoriteButton(
              memberId: m.id,
              activeColor: _pink,
              inactiveColor: _ink,
              iconSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 1. POLAROID HERO SECTION
  // ===========================================================================
  Widget _buildPolaroidHeroSection(
    GroupMember m,
    int applauseCount,
    MemberProvider provider,
    double screenWidth,
  ) {
    final isWide = screenWidth >= 620;

    final polaroidCard = AnimatedRotation(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      turns: _polaroidAngle,
      child: GestureDetector(
        onTap: _togglePolaroidTilt,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: isWide ? 220 : 205,
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
              decoration: _neoBox(
                color: Colors.white,
                radius: 14,
                borderWidth: 3,
                shadowOffset: const Offset(7, 7),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Polaroid Photo Frame
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: _ink, width: 2.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Hero(
                      tag: 'photo_${m.id}',
                      child: MemberPhoto(
                        assetPath: m.photoAsset,
                        memberNumber: m.memberNumber,
                        accentColor: _purple,
                        width: isWide ? 190 : 175,
                        height: isWide ? 205 : 190,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Handwritten style signature / student label
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: _yellow),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          m.fullName.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _ink,
                            fontWeight: FontWeight.w900,
                            fontSize: 11.5,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _bgCanvas,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _ink, width: 1.5),
                    ),
                    child: Text(
                      m.studentId,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '⚡ TAP PHOTO TO TILT',
                    style: TextStyle(
                      color: _purpleDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),

            // Top Washi Tape Corner
            Positioned(
              top: -10,
              left: 40,
              child: Transform.rotate(
                angle: -0.15,
                child: Container(
                  width: 68,
                  height: 22,
                  decoration: BoxDecoration(
                    color: _yellow.withValues(alpha: 0.85),
                    border: Border.all(color: _ink.withValues(alpha: 0.4), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        offset: const Offset(1, 2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom-right sticker badge
            Positioned(
              bottom: -10,
              right: -10,
              child: Transform.rotate(
                angle: 0.12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: _neoBox(
                    color: _pink,
                    radius: 20,
                    borderWidth: 2,
                    shadowOffset: const Offset(3, 3),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt_rounded, size: 14, color: Colors.white),
                      SizedBox(width: 2),
                      Text(
                        'SE INTERN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final bioInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Badge Pill
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: _neoBox(
                color: _pink,
                radius: 20,
                borderWidth: 2,
                shadowOffset: const Offset(2.5, 2.5),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.work_outline_rounded, size: 14, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'OPEN TO COLLAB // 2026',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: _neoBox(
                color: _mint,
                radius: 20,
                borderWidth: 2,
                shadowOffset: const Offset(2.5, 2.5),
              ),
              child: const Text(
                'NDIT @ ITUM',
                style: TextStyle(
                  color: _ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Bold Expressive Name with Neo highlight
        Stack(
          children: [
            Positioned(
              bottom: 4,
              left: 0,
              right: 20,
              height: 16,
              child: Container(
                color: _yellow,
              ),
            ),
            Text(
              m.fullName.toUpperCase(),
              style: const TextStyle(
                color: _ink,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                height: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Role Badge Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: _neoBox(
            color: _purple,
            radius: 8,
            borderWidth: 2,
            shadowOffset: const Offset(3, 3),
          ),
          child: Text(
            m.shortRole.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Short Description
        Text(
          m.shortDescription,
          style: const TextStyle(
            color: _ink,
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 18),

        // Interactive Applaud Button (Neo-Brutalist Push Button)
        InkWell(
          onTap: () {
            HapticFeedback.heavyImpact();
            provider.addEndorsement(m.id);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: _purpleDark,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: _yellow, width: 2),
                ),
                content: Row(
                  children: [
                    const Icon(Icons.thumb_up_alt_rounded, color: _yellow, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Applauded ${m.fullName}! Total: ${applauseCount + 1}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: _neoBox(
              color: _yellow,
              radius: 12,
              borderWidth: 2.5,
              shadowOffset: const Offset(4, 4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite_rounded, size: 18, color: _pink),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'APPLAUD TALENT ($applauseCount)',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.add, size: 16, color: _ink),
              ],
            ),
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(isWide ? 24 : 18),
      decoration: _neoBox(
        color: _purpleSoft,
        radius: 20,
        borderWidth: 3,
        shadowOffset: const Offset(6, 6),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                polaroidCard,
                const SizedBox(width: 32),
                Expanded(child: bioInfo),
              ],
            )
          : Column(
              children: [
                polaroidCard,
                const SizedBox(height: 24),
                bioInfo,
              ],
            ),
    );
  }

  // ===========================================================================
  // 2. CONTACT & SOCIAL STICKER BAR
  // ===========================================================================
  Widget _buildContactStickerBar(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          tagText: 'GET IN TOUCH',
          title: 'CONTACT & REPOSITORIES',
          tagColor: _pink,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            // Email sticker
            _buildInteractiveSticker(
              icon: Icons.alternate_email_rounded,
              label: 'EMAIL',
              value: m.email,
              bgColor: _yellowLight,
              onTap: () => _copyToClipboard('Email', m.email),
            ),
            // Phone sticker
            _buildInteractiveSticker(
              icon: Icons.phone_android_rounded,
              label: 'PHONE',
              value: '077 490 4933',
              bgColor: _pinkSoft,
              onTap: () => _copyToClipboard('Phone', '077 490 4933'),
            ),
            // Location sticker
            _buildInteractiveSticker(
              icon: Icons.location_on_rounded,
              label: 'LOCATION',
              value: m.address,
              bgColor: Colors.white,
              onTap: () => _copyToClipboard('Location', m.address),
            ),
            // GitHub sticker
            _buildInteractiveSticker(
              icon: Icons.code_rounded,
              label: 'GITHUB',
              value: 'github.com/NimeshikaSewwandi',
              bgColor: _purpleSoft,
              onTap: () => _copyToClipboard('GitHub', 'https://github.com/NimeshikaSewwandi'),
            ),
            // LinkedIn sticker
            _buildInteractiveSticker(
              icon: Icons.link_rounded,
              label: 'LINKEDIN',
              value: 'linkedin.com/in/nimeshika-sewwandi',
              bgColor: _yellowLight,
              onTap: () => _copyToClipboard('LinkedIn', 'https://linkedin.com/in/nimeshika-sewwandi-167040360'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveSticker({
    required IconData icon,
    required String label,
    required String value,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: _neoBox(
          color: bgColor,
          radius: 12,
          borderWidth: 2,
          shadowOffset: const Offset(3, 3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: _ink),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.copy_rounded, size: 12, color: _ink),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. CREATIVE ABOUT ME / BLUEPRINT DOSSIER
  // ===========================================================================
  Widget _buildCreativeAboutMe(GroupMember m) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _neoBox(
        color: Colors.white,
        radius: 18,
        borderWidth: 3,
        shadowOffset: const Offset(5, 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildSectionHeader(
                  tagText: 'BLUEPRINT',
                  title: 'ABOUT NIMESHIKA ⚡',
                  tagColor: _yellow,
                ),
              ),
              const SizedBox(width: 8),
              Transform.rotate(
                angle: 0.08,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _ink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '★ CA 02',
                    style: TextStyle(
                      color: _yellow,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Speech Bubble / Manifesto
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _yellowLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _ink, width: 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote_rounded, size: 28, color: _ink),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    m.bioQuote,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Fast facts grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 520;
              return GridView.count(
                crossAxisCount: isWide ? 4 : 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: isWide ? 1.4 : 1.6,
                children: [
                  _buildFactCard('PROGRAM', 'NDIT (Moratuwa)', _purpleSoft, Icons.school_rounded),
                  _buildFactCard('CURRENT GPA', '2.51 / 4.00', _yellowLight, Icons.analytics_rounded),
                  _buildFactCard('BASE CITY', 'Mahiyanganaya', _pinkSoft, Icons.place_rounded),
                  _buildFactCard('LANGUAGES', 'Sinhala & English', _bgCanvas, Icons.translate_rounded),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Academic References Accordion Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _bgCanvas,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _ink, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.verified_user_rounded, size: 16, color: _purpleDark),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'ACADEMIC REFERENCES (ITUM)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                          color: _ink,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, refConstraints) {
                    final isNarrow = refConstraints.maxWidth < 420;
                    if (isNarrow) {
                      return const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• Mrs. Uthpala Athukorala\n  Lecturer, Institute of Technology, UOM',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _ink),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '• Mrs. Shashika Ruwanmini\n  Lecturer, Institute of Technology, UOM',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _ink),
                          ),
                        ],
                      );
                    }
                    return const Row(
                      children: [
                        Expanded(
                          child: Text(
                            '• Mrs. Uthpala Athukorala\n  Lecturer, Institute of Technology, UOM',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _ink),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '• Mrs. Shashika Ruwanmini\n  Lecturer, Institute of Technology, UOM',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _ink),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactCard(String title, String val, Color bg, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: _neoBox(
        color: bg,
        radius: 10,
        borderWidth: 2,
        shadowOffset: const Offset(2.5, 2.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: _ink),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                    color: _ink,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            val,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. ACADEMIC QUALIFICATIONS DECK (INTERACTIVE PAGEVIEW)
  // ===========================================================================
  Widget _buildAcademicDeck(GroupMember m) {
    final qualls = m.qualifications;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildSectionHeader(
                tagText: 'DECK 01',
                title: 'ACADEMIC DECK',
                tagColor: _purple,
              ),
            ),
            const SizedBox(width: 8),
            // Page controls
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCarouselArrow(
                  icon: Icons.chevron_left_rounded,
                  onTap: _currentEduPage > 0
                      ? () => _eduPageController.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          )
                      : null,
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _ink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${_currentEduPage + 1} / ${qualls.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _buildCarouselArrow(
                  key: const Key('edu_next_button'),
                  icon: Icons.chevron_right_rounded,
                  onTap: _currentEduPage < qualls.length - 1
                      ? () => _eduPageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          )
                      : null,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Carousel Container
        SizedBox(
          height: 195,
          child: PageView.builder(
            controller: _eduPageController,
            itemCount: qualls.length,
            onPageChanged: (idx) => setState(() => _currentEduPage = idx),
            itemBuilder: (context, index) {
              final q = qualls[index];
              final cardBgs = [
                _purpleSoft,
                _yellowLight,
                _pinkSoft,
                const Color(0xFFD1FAE5),
                const Color(0xFFFFEDD5),
                Colors.white,
              ];
              final bg = cardBgs[index % cardBgs.length];

              return Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: _neoBox(
                    color: bg,
                    radius: 16,
                    borderWidth: 2.5,
                    shadowOffset: const Offset(4, 4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Level Badge + Year
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _ink,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                q.level.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: _yellow,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 11,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: _ink, width: 1.5),
                            ),
                            child: Text(
                              q.year,
                              style: const TextStyle(
                                color: _ink,
                                fontWeight: FontWeight.w900,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Title
                      Text(
                        q.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Institution
                      Row(
                        children: [
                          const Icon(Icons.account_balance_rounded, size: 14, color: _ink),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              q.institution,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _ink,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Status / Grade Chip
                      if (q.gradeOrStatus != null && q.gradeOrStatus!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: _ink, width: 1.5),
                          ),
                          child: Text(
                            q.gradeOrStatus!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _purpleDark,
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                            ),
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

  // ===========================================================================
  // 5. SKILLS ARSENAL (COLOURFUL VINYL STICKER PACK)
  // ===========================================================================
  Widget _buildSkillsArsenal(GroupMember m) {
    // Technical Skills extracted directly from Nimeshika's Resume
    final techSkills = [
      {'name': 'Python', 'cat': 'code', 'bg': _yellow},
      {'name': 'Java', 'cat': 'code', 'bg': _yellowLight},
      {'name': 'HTML5', 'cat': 'code', 'bg': _pinkSoft},
      {'name': 'CSS3', 'cat': 'code', 'bg': _purpleSoft},
      {'name': 'JavaScript', 'cat': 'code', 'bg': _yellow},
      {'name': 'PHP', 'cat': 'code', 'bg': _purpleSoft},
      {'name': 'React.js', 'cat': 'code', 'bg': _mint},
      {'name': 'MySQL', 'cat': 'code', 'bg': _orange},
      {'name': 'Git & GitHub', 'cat': 'tools', 'bg': Colors.white},
      {'name': 'Figma (UI/UX)', 'cat': 'tools', 'bg': _pink},
      {'name': 'Microsoft Office', 'cat': 'tools', 'bg': _bgCanvas},
    ];

    // Filter skills according to tab
    List<Widget> stickerChips = [];

    if (_selectedSkillTab == 'All' || _selectedSkillTab == 'Code') {
      for (final s in techSkills.where((item) => _selectedSkillTab == 'All' || item['cat'] == 'code')) {
        stickerChips.add(
          _buildSkillVinylSticker(
            name: s['name'] as String,
            bgColor: s['bg'] as Color,
            icon: Icons.code_rounded,
          ),
        );
      }
    }

    if (_selectedSkillTab == 'All' || _selectedSkillTab == 'Tools & Design') {
      for (final s in techSkills.where((item) => _selectedSkillTab == 'All' || item['cat'] == 'tools')) {
        stickerChips.add(
          _buildSkillVinylSticker(
            name: s['name'] as String,
            bgColor: s['bg'] as Color,
            icon: Icons.brush_rounded,
          ),
        );
      }
    }

    if (_selectedSkillTab == 'All' || _selectedSkillTab == 'Soft Skills') {
      for (final s in m.softSkills) {
        stickerChips.add(
          _buildSkillVinylSticker(
            name: '${s.name} • ${(s.level * 100).round()}%',
            bgColor: _mint,
            icon: Icons.psychology_rounded,
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _neoBox(
        color: Colors.white,
        radius: 18,
        borderWidth: 3,
        shadowOffset: const Offset(5, 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildSectionHeader(
                  tagText: 'PACK 02',
                  title: 'SKILLS STICKER PACK',
                  tagColor: _mint,
                ),
              ),
              IconButton(
                tooltip: 'Toggle Soft Skill Percentage Bars',
                onPressed: () {
                  HapticFeedback.selectionClick();
                  setState(() => _showSoftSkillBars = !_showSoftSkillBars);
                },
                icon: Icon(
                  _showSoftSkillBars ? Icons.bar_chart_rounded : Icons.label_outline_rounded,
                  color: _ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Category Selector Pills
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterPill('All'),
              _buildFilterPill('Code'),
              _buildFilterPill('Tools & Design'),
              _buildFilterPill('Soft Skills'),
            ],
          ),
          const SizedBox(height: 16),

          // Vinyl Stickers Wrap
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: stickerChips,
          ),

          // Optional Soft Skills Progress Deck
          if (_showSoftSkillBars) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _bgCanvas,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _ink, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '★ SOFT SKILLS PROFICIENCY METERS',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      color: _ink,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...m.softSkills.map((s) => _buildSoftSkillBar(s)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterPill(String tabName) {
    final isSelected = _selectedSkillTab == tabName;
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedSkillTab = tabName);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _ink : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _ink, width: 2),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: _yellow,
                    offset: Offset(2, 2),
                    blurRadius: 0,
                  )
                ]
              : null,
        ),
        child: Text(
          tabName.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : _ink,
            fontWeight: FontWeight.w900,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillVinylSticker({
    required String name,
    required Color bgColor,
    required IconData icon,
  }) {
    final isDark = bgColor == _pink || bgColor == _ink || bgColor == _purple;

    return Container(
      constraints: const BoxConstraints(maxWidth: 290),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: _neoBox(
        color: bgColor,
        radius: 30,
        borderWidth: 2,
        shadowOffset: const Offset(2.5, 2.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: isDark ? Colors.white : _ink),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? Colors.white : _ink,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSoftSkillBar(SoftSkill s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                s.name,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: _ink),
              ),
              Text(
                '${(s.level * 100).round()}%',
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: _purpleDark),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _ink, width: 2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: s.level.clamp(0.0, 1.0),
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: _yellow,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _ink, width: 2),
                  ),
                ),
              ),
            ],
          ),
          if (s.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              s.description,
              style: TextStyle(fontSize: 11, color: _ink.withValues(alpha: 0.75)),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 6. FEATURED RESUME PROJECTS DECK (INTERACTIVE PAGEVIEW)
  // ===========================================================================
  Widget _buildFeaturedProjectsDeck() {
    final projects = [
      {
        'title': 'SentinelCare | Smart Medical Hand Band',
        'type': 'Team Project • IoT & Health Tech',
        'year': '2026',
        'desc':
            'Intelligent health-monitoring wearable designed to support elderly living alone. Monitors vital signs in real time, fall detection, medication alerts, and caregiver web dashboard.',
        'myRole': 'Frontend Web App modules for Login, Sign Up, Settings & Authentication.',
        'tech': ['IoT', 'Mobile App', 'Sensors', 'React.js', 'Web Dashboard'],
        'repo': 'github.com/NisalAluthge/SentinelCare',
        'bg': _yellowLight,
      },
      {
        'title': 'Real-Time Chat Application',
        'type': 'Full-Stack Web Application',
        'year': '2026',
        'desc':
            'Full-stack chat application with real-time messaging, contact selection, JWT secure authentication, and MySQL database for storing persistent user histories.',
        'myRole': 'Built responsive frontend with React.js and backend with Node.js & MySQL.',
        'tech': ['React.js', 'JavaScript', 'Node.js', 'MySQL', 'JWT Auth'],
        'repo': 'github.com/NimeshikaSewwandi/chat-application',
        'bg': _purpleSoft,
      },
      {
        'title': 'Student Event Management System',
        'type': 'Web Application Platform',
        'year': '2025',
        'desc':
            'Centralized web platform designed to streamline student event coordination, registrations, database management, and committee scheduling workflows.',
        'myRole': 'End-to-end database schema modeling, PHP API handlers, and UI design.',
        'tech': ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL'],
        'repo': 'github.com/NimeshikaSewwandi/Student-Event-Management-System',
        'bg': _pinkSoft,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildSectionHeader(
                tagText: 'PROJECTS',
                title: 'FEATURED BUILDS',
                tagColor: _yellow,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCarouselArrow(
                  icon: Icons.chevron_left_rounded,
                  onTap: _currentProjectPage > 0
                      ? () => _projectPageController.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          )
                      : null,
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _ink,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${_currentProjectPage + 1} / ${projects.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _buildCarouselArrow(
                  icon: Icons.chevron_right_rounded,
                  onTap: _currentProjectPage < projects.length - 1
                      ? () => _projectPageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          )
                      : null,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 270,
          child: PageView.builder(
            controller: _projectPageController,
            itemCount: projects.length,
            onPageChanged: (idx) => setState(() => _currentProjectPage = idx),
            itemBuilder: (context, index) {
              final p = projects[index];
              final bg = p['bg'] as Color;
              final techList = p['tech'] as List<String>;

              return Padding(
                padding: const EdgeInsets.only(right: 12, bottom: 8),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: _neoBox(
                    color: bg,
                    radius: 16,
                    borderWidth: 2.5,
                    shadowOffset: const Offset(4, 4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _ink,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                (p['type'] as String).toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: _yellow,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            p['year'] as String,
                            style: const TextStyle(
                              color: _ink,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        p['title'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p['desc'] as String,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                      const Spacer(),
                      // Tech Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: techList
                            .map(
                              (t) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: _ink, width: 1.5),
                                ),
                                child: Text(
                                  t,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                    color: _ink,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 8),
                      // Repo Link button
                      InkWell(
                        onTap: () => _copyToClipboard('Project Link', 'https://${p['repo']}'),
                        child: Row(
                          children: [
                            const Icon(Icons.code_rounded, size: 14, color: _ink),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                p['repo'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  color: _purpleDark,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const Icon(Icons.copy_rounded, size: 12, color: _purpleDark),
                          ],
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

  // ===========================================================================
  // 7. ILLUSTRATED TALENTS & HOBBIES SHOWCASE
  // ===========================================================================
  Widget _buildTalentsShowcase(GroupMember m) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          tagText: 'PASSIONS',
          title: 'TALENTS & HOBBIES',
          tagColor: _pink,
        ),
        const SizedBox(height: 14),
        ...m.talents.map((t) {
          final cheers = _talentCheers[t.title] ?? 0;
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: _neoBox(
              color: Colors.white,
              radius: 16,
              borderWidth: 2.5,
              shadowOffset: const Offset(4, 4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Illustrated Icon Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _yellow,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _ink, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: _ink,
                        offset: Offset(2.5, 2.5),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _iconForTalentCategory(t.category),
                    color: _ink,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),

                // Talent Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              t.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14.5,
                                color: _ink,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _purpleSoft,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: _ink, width: 1.5),
                            ),
                            child: Text(
                              t.category.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 9.5,
                                color: _purpleDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        t.detail,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF374151),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Interactive Cheer Button
                      InkWell(
                        key: t.title == m.talents.first.title
                            ? const Key('cheer_first_talent')
                            : null,
                        onTap: () => _cheerTalent(t.title),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: cheers > 0 ? _yellowLight : _bgCanvas,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _ink, width: 1.5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                cheers > 0 ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                size: 14,
                                color: _pink,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                cheers > 0 ? 'Cheered ($cheers)' : 'Send Cheer',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  color: _ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  IconData _iconForTalentCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('design') || lower.contains('art')) {
      return Icons.palette_rounded;
    } else if (lower.contains('tech') || lower.contains('hardware')) {
      return Icons.memory_rounded;
    } else if (lower.contains('coding') || lower.contains('engineering')) {
      return Icons.terminal_rounded;
    } else if (lower.contains('music')) {
      return Icons.music_note_rounded;
    } else {
      return Icons.auto_awesome_rounded;
    }
  }

  // ===========================================================================
  // 8. NEO-BRUTALIST FOOTER
  // ===========================================================================
  Widget _buildNeoFooter(GroupMember m) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: _neoBox(
            color: _yellow,
            radius: 18,
            borderWidth: 3,
            shadowOffset: const Offset(5, 5),
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_rounded, color: _ink, size: 20),
                    SizedBox(width: 6),
                    Text(
                      'NEXAPROFILE // STUDIO M-03',
                      style: TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.star_rounded, color: _ink, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${m.fullName} • ${m.address}',
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  decoration: _neoBox(
                    color: Colors.white,
                    radius: 12,
                    borderWidth: 2.5,
                    shadowOffset: const Offset(3, 3),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.grid_view_rounded, size: 16, color: _ink),
                      SizedBox(width: 8),
                      Text(
                        'BACK TO DIRECTORY',
                        style: TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Section Header Helper
  Widget _buildSectionHeader({
    required String tagText,
    required String title,
    required Color tagColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _ink, width: 1.5),
          ),
          child: Text(
            tagText,
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w900,
              fontSize: 19,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselArrow({Key? key, required IconData icon, required VoidCallback? onTap}) {
    return InkWell(
      key: key,
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 34,
        height: 34,
        decoration: _neoBox(
          color: onTap != null ? Colors.white : Colors.grey.shade300,
          radius: 8,
          borderWidth: 2,
          shadowOffset: onTap != null ? const Offset(2, 2) : Offset.zero,
        ),
        child: Icon(icon, color: onTap != null ? _ink : Colors.grey.shade600, size: 20),
      ),
    );
  }
}
