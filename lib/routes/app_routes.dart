import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/screens/home/home_screen.dart';
import 'package:group_profile_app/screens/login/login_screen.dart';
import 'package:group_profile_app/screens/members/member_01_screen.dart';
import 'package:group_profile_app/screens/members/member_02_screen.dart';
import 'package:group_profile_app/screens/members/member_03_screen.dart';
import 'package:group_profile_app/screens/members/member_04_screen.dart';
import 'package:group_profile_app/screens/members/member_05_screen.dart';
import 'package:group_profile_app/screens/members/member_06_screen.dart';
import 'package:group_profile_app/screens/members/member_07_screen.dart';
import 'package:group_profile_app/screens/members/member_08_screen.dart';
import 'package:group_profile_app/screens/members/member_09_screen.dart';
import 'package:group_profile_app/widgets/auth_gate.dart';
import 'package:provider/provider.dart';

/// Centralized route names, auth-guarded navigation, and member bio dispatch.
class AppRoutes {
  AppRoutes._();

  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String memberBio = '/member-bio';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return _fadeSlideRoute(
          settings,
          AuthGate(authenticatedBuilder: (_) => const HomeScreen()),
        );
      case login:
        return _fadeSlideRoute(settings, const LoginScreen());
      case home:
        return _fadeSlideRoute(
          settings,
          AuthGate(authenticatedBuilder: (_) => const HomeScreen()),
        );
      case memberBio:
        final memberId = settings.arguments as String?;
        return _fadeSlideRoute(
          settings,
          AuthGate(
            authenticatedBuilder: (context) =>
                _buildMemberScreen(context, memberId),
          ),
        );
      default:
        return _fadeSlideRoute(
          settings,
          AuthGate(authenticatedBuilder: (_) => const HomeScreen()),
        );
    }
  }

  static Widget _buildMemberScreen(BuildContext context, String? memberId) {
    final provider = context.read<MemberProvider>();
    final GroupMember? member =
        memberId != null ? provider.findById(memberId) : null;

    if (member == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Member Not Found')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Requested member profile could not be found.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to Directory'),
              ),
            ],
          ),
        ),
      );
    }

    switch (member.memberNumber) {
      case 1:
        return Member01Screen(member: member);
      case 2:
        return Member02Screen(member: member);
      case 3:
        return Member03Screen(member: member);
      case 4:
        return Member04Screen(member: member);
      case 5:
        return Member05Screen(member: member);
      case 6:
        return Member06Screen(member: member);
      case 7:
        return Member07Screen(member: member);
      case 8:
        return Member08Screen(member: member);
      case 9:
        return Member09Screen(member: member);
      default:
        return Member01Screen(member: member);
    }
  }

  static PageRoute<dynamic> _fadeSlideRoute(
    RouteSettings settings,
    Widget child,
  ) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (_, _, _) => child,
      transitionsBuilder: (_, animation, _, page) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.03, 0),
              end: Offset.zero,
            ).animate(curved),
            child: page,
          ),
        );
      },
    );
  }
}
