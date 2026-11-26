import 'package:flutter/material.dart';

/// Displays a member's local asset photograph with graceful fallback graphics
/// if an asset has not yet been supplied or is temporarily missing.
class MemberPhoto extends StatelessWidget {
  const MemberPhoto({
    super.key,
    required this.assetPath,
    required this.memberNumber,
    required this.accentColor,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  final String assetPath;
  final int memberNumber;
  final Color accentColor;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accentColor.withValues(alpha: 0.85),
                accentColor.withValues(alpha: 0.45),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_rounded, size: 40, color: Colors.white),
              const SizedBox(height: 4),
              Text(
                'M${memberNumber.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }
    return image;
  }
}
