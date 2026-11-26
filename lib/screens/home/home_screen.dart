import 'package:flutter/material.dart';
import 'package:group_profile_app/constants/app_colors.dart';
import 'package:group_profile_app/constants/app_constants.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/providers/auth_provider.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/routes/app_routes.dart';
import 'package:group_profile_app/widgets/favorite_button.dart';
import 'package:group_profile_app/widgets/member_photo.dart';
import 'package:provider/provider.dart';

/// Home / Member Directory screen displaying all 9 group members with search,
/// favourites filter, grid/list switch, profile menu, and logout action.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text(
          'Are you sure you want to log out and return to the login screen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(ctx).pop(true),
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await context.read<AuthProvider>().signOut();
    }
  }

  void _openMemberBio(GroupMember member) {
    Navigator.of(context).pushNamed(
      AppRoutes.memberBio,
      arguments: member.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final memberProvider = context.watch<MemberProvider>();
    final members = memberProvider.filteredMembers;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppConstants.appTitle,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
            ),
            Text(
              '${memberProvider.allMembers.length} Group Members • 9 Unique Designs',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: memberProvider.isDarkMode
                ? 'Switch to light theme'
                : 'Switch to dark theme',
            onPressed: memberProvider.toggleThemeMode,
            icon: Icon(
              memberProvider.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          PopupMenuButton<String>(
            key: const Key('profile_menu_button'),
            tooltip: 'Account menu',
            offset: const Offset(0, 48),
            icon: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary.withValues(alpha: 0.14),
              child: const Icon(
                Icons.person_outline_rounded,
                size: 19,
                color: AppColors.primary,
              ),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                _confirmLogout();
              } else if (value == 'theme') {
                memberProvider.toggleThemeMode();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Signed in as',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      auth.user?.email ?? 'Authenticated User',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(
                      memberProvider.isDarkMode
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(memberProvider.isDarkMode ? 'Light Theme' : 'Dark Theme'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                key: Key('menu_logout_item'),
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded, size: 18, color: AppColors.error),
                    SizedBox(width: 10),
                    Text('Logout', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            key: const Key('appbar_logout_button'),
            tooltip: 'Logout',
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final crossAxisCount = width >= 1080
              ? 4
              : width >= 720
                  ? 3
                  : width >= 380
                      ? 2
                      : 1;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeBanner(auth, theme),
                      const SizedBox(height: 14),
                      _buildSearchAndControls(memberProvider, theme),
                    ],
                  ),
                ),
              ),
              if (members.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(memberProvider, theme),
                )
              else if (memberProvider.isGridView)
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: width >= 720 ? 0.78 : 0.72,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _MemberGridCard(
                        member: members[index],
                        onTap: () => _openMemberBio(members[index]),
                      ),
                      childCount: members.length,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _MemberListTileCard(
                          member: members[index],
                          onTap: () => _openMemberBio(members[index]),
                        ),
                      ),
                      childCount: members.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildWelcomeBanner(AuthProvider auth, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A8A), Color(0xFF0D9488)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Group Member Directory',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap any card to explore one of 9 original bio screen designs.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                if ((auth.user?.email ?? '').isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Active: ${auth.user!.email}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndControls(
    MemberProvider memberProvider,
    ThemeData theme,
  ) {
    return Column(
      children: [
        TextField(
          key: const Key('directory_search_field'),
          controller: _searchController,
          onChanged: memberProvider.setSearchQuery,
          decoration: InputDecoration(
            hintText: 'Search by name, role, skill, city, or design...',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: memberProvider.searchQuery.isNotEmpty
                ? IconButton(
                    tooltip: 'Clear search',
                    onPressed: () {
                      _searchController.clear();
                      memberProvider.clearSearch();
                    },
                    icon: const Icon(Icons.close_rounded),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    selected: !memberProvider.onlyFavorites,
                    label: Text('All (${memberProvider.allMembers.length})'),
                    onSelected: (_) {
                      if (memberProvider.onlyFavorites) {
                        memberProvider.toggleOnlyFavorites();
                      }
                    },
                  ),
                  FilterChip(
                    key: const Key('favorites_filter_chip'),
                    selected: memberProvider.onlyFavorites,
                    avatar: const Icon(Icons.favorite_rounded, size: 16),
                    label: Text('Favourites (${memberProvider.favoriteCount})'),
                    onSelected: (_) => memberProvider.toggleOnlyFavorites(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment<bool>(
                  value: true,
                  icon: Icon(Icons.grid_view_rounded, size: 18),
                  tooltip: 'Grid layout',
                ),
                ButtonSegment<bool>(
                  value: false,
                  icon: Icon(Icons.view_agenda_outlined, size: 18),
                  tooltip: 'List layout',
                ),
              ],
              selected: {memberProvider.isGridView},
              onSelectionChanged: (selection) {
                if (selection.first != memberProvider.isGridView) {
                  memberProvider.toggleViewMode();
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(MemberProvider provider, ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_rounded,
              size: 56,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              'No matching group members',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Try clearing the search text or disabling the favourites filter.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: () {
                _searchController.clear();
                provider.clearSearch();
                if (provider.onlyFavorites) {
                  provider.toggleOnlyFavorites();
                }
              },
              child: const Text('Reset Filters'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberGridCard extends StatelessWidget {
  const _MemberGridCard({
    required this.member,
    required this.onTap,
  });

  final GroupMember member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key('member_card_${member.id}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'photo_${member.id}',
                    child: MemberPhoto(
                      assetPath: member.photoAsset,
                      memberNumber: member.memberNumber,
                      accentColor: member.accentColor,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '#${member.memberNumber.toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: FavoriteButton(
                      memberId: member.id,
                      iconSize: 18,
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      inactiveColor: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: member.accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        member.designStyleName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: member.accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      member.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Expanded(
                      child: Text(
                        member.shortDescription,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontSize: 11.5,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberListTileCard extends StatelessWidget {
  const _MemberListTileCard({
    required this.member,
    required this.onTap,
  });

  final GroupMember member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key('member_list_card_${member.id}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: 'photo_${member.id}',
                child: MemberPhoto(
                  assetPath: member.photoAsset,
                  memberNumber: member.memberNumber,
                  accentColor: member.accentColor,
                  width: 78,
                  height: 78,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: member.accentColor.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'M${member.memberNumber.toString().padLeft(2, '0')} • ${member.designStyleName}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: member.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      member.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      member.shortDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              FavoriteButton(memberId: member.id),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
