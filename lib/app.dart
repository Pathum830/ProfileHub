import 'package:flutter/material.dart';
import 'package:group_profile_app/constants/app_constants.dart';
import 'package:group_profile_app/constants/app_theme.dart';
import 'package:group_profile_app/providers/auth_provider.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/routes/app_routes.dart';
import 'package:group_profile_app/services/auth_service.dart';
import 'package:provider/provider.dart';

/// Root application widget configuring MultiProvider state management,
/// responsive Material 3 themes, and auth-guarded routing.
class GroupProfileApp extends StatefulWidget {
  const GroupProfileApp({
    super.key,
    this.authService,
  });

  final AuthService? authService;

  @override
  State<GroupProfileApp> createState() => _GroupProfileAppState();
}

class _GroupProfileAppState extends State<GroupProfileApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final AuthProvider _authProvider;
  bool _wasAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _authProvider = AuthProvider(
      authService: widget.authService ?? FirebaseAuthService(),
    );
    _wasAuthenticated = _authProvider.isAuthenticated;
    _authProvider.addListener(_handleAuthChange);
  }

  void _handleAuthChange() {
    final isAuthNow = _authProvider.isAuthenticated;
    if (_wasAuthenticated && !isAuthNow) {
      // Clear any deep member routes when user signs out.
      _navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    _wasAuthenticated = isAuthNow;
  }

  @override
  void dispose() {
    _authProvider.removeListener(_handleAuthChange);
    _authProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>.value(value: _authProvider),
        ChangeNotifierProvider<MemberProvider>(create: (_) => MemberProvider()),
      ],
      child: Consumer<MemberProvider>(
        builder: (context, memberProvider, _) {
          return MaterialApp(
            navigatorKey: _navigatorKey,
            title: AppConstants.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: memberProvider.themeMode,
            initialRoute: AppRoutes.root,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
