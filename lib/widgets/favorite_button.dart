import 'package:flutter/material.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:provider/provider.dart';

/// Reusable animated favourite button synced with [MemberProvider].
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.memberId,
    this.activeColor = const Color(0xFFE11D48),
    this.inactiveColor,
    this.backgroundColor,
    this.iconSize = 22,
  });

  final String memberId;
  final Color activeColor;
  final Color? inactiveColor;
  final Color? backgroundColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MemberProvider>();
    final isFav = provider.isFavorite(memberId);

    final button = IconButton(
      tooltip: isFav ? 'Remove from favourites' : 'Add to favourites',
      onPressed: () => provider.toggleFavorite(memberId),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        transitionBuilder: (child, anim) =>
            ScaleTransition(scale: anim, child: child),
        child: Icon(
          isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          key: ValueKey<bool>(isFav),
          size: iconSize,
          color: isFav
              ? activeColor
              : (inactiveColor ?? Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ),
    );

    if (backgroundColor != null) {
      return Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        child: button,
      );
    }
    return button;
  }
}
