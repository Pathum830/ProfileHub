import 'package:flutter/material.dart';
import 'package:group_profile_app/providers/auth_provider.dart';
import 'package:group_profile_app/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

/// Protects authenticated routes so unauthenticated users are always directed
/// back to [LoginScreen].
class AuthGate extends StatelessWidget {
  const AuthGate({
    super.key,
    required this.authenticatedBuilder,
  });

  final WidgetBuilder authenticatedBuilder;

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select<AuthProvider, bool>(
      (auth) => auth.isAuthenticated,
    );

    if (!isAuthenticated) {
      return const LoginScreen();
    }
    return authenticatedBuilder(context);
  }
}
