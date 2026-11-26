import 'package:flutter/material.dart';
import 'package:group_profile_app/constants/app_colors.dart';
import 'package:group_profile_app/constants/app_constants.dart';
import 'package:group_profile_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

/// Firebase-powered Login & Registration screen (first screen when signed out).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isRegisterMode = false;
  bool _prefilledEmail = false;

  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_prefilledEmail) {
      final remembered = context.read<AuthProvider>().rememberedEmail;
      if (remembered.isNotEmpty && _emailController.text.isEmpty) {
        _emailController.text = remembered;
      }
      _prefilledEmail = true;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final auth = context.read<AuthProvider>();
    auth.clearError();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final success = _isRegisterMode
        ? await auth.register(email: email, password: password)
        : await auth.signIn(email: email, password: password);

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isRegisterMode
                ? 'Account created and signed in as $email'
                : 'Welcome back, $email',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _toggleMode() {
    context.read<AuthProvider>().clearError();
    setState(() {
      _isRegisterMode = !_isRegisterMode;
      _confirmPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [Color(0xFF090F1E), Color(0xFF111C33), Color(0xFF0B1120)]
                : const [Color(0xFFEFF6FF), Color(0xFFF8FAFC), Color(0xFFF0FDFA)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(theme),
                    const SizedBox(height: 24),
                    if (!auth.isFirebaseConfigured) ...[
                      _buildFirebaseNotice(theme),
                      const SizedBox(height: 16),
                    ],
                    _buildFormCard(context, auth, theme, isDark),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary],
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.28),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.groups_rounded,
            color: Colors.white,
            size: 38,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            AppConstants.courseName.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppConstants.appTitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppConstants.groupSummary,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildFirebaseNotice(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: AppColors.warning),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Firebase project not linked yet. Run `flutterfire configure` or add your `google-services.json` (see README.md) to enable live Firebase sign-in.',
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard(
    BuildContext context,
    AuthProvider auth,
    ThemeData theme,
    bool isDark,
  ) {
    return Card(
      elevation: 0,
      color: isDark ? AppColors.darkSurface : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isRegisterMode ? 'Create Test Account' : 'Member Sign In',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isRegisterMode
                              ? 'Register an email & password in Firebase Auth'
                              : 'Sign in with your Firebase email and password',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (auth.errorMessage != null) ...[
                _ErrorBanner(message: auth.errorMessage!),
                const SizedBox(height: 16),
              ],
              TextFormField(
                key: const Key('login_email_field'),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                onChanged: (_) => auth.clearError(),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'student@university.edu',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Please enter your email address.';
                  }
                  if (!_emailRegex.hasMatch(text)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('login_password_field'),
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction:
                    _isRegisterMode ? TextInputAction.next : TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                onChanged: (_) => auth.clearError(),
                onFieldSubmitted: (_) {
                  if (!_isRegisterMode && !auth.isLoading) {
                    _submit();
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    key: const Key('toggle_password_visibility'),
                    tooltip:
                        _obscurePassword ? 'Show password' : 'Hide password',
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  final text = value ?? '';
                  if (text.isEmpty) {
                    return 'Please enter your password.';
                  }
                  if (text.length < 6) {
                    return 'Password must be at least 6 characters.';
                  }
                  return null;
                },
              ),
              if (_isRegisterMode) ...[
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('register_confirm_password_field'),
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    if (!auth.isLoading) _submit();
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: const Icon(Icons.verified_user_outlined),
                    suffixIcon: IconButton(
                      tooltip: _obscureConfirmPassword
                          ? 'Show password'
                          : 'Hide password',
                      onPressed: () {
                        setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        );
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: auth.rememberEmail,
                    onChanged: auth.isLoading
                        ? null
                        : (val) => auth.setRememberEmail(val ?? true),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: auth.isLoading
                          ? null
                          : () => auth.setRememberEmail(!auth.rememberEmail),
                      child: Text(
                        'Remember email on this device',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                key: const Key('login_submit_button'),
                onPressed: auth.isLoading ? null : _submit,
                child: auth.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(_isRegisterMode ? 'Create Account' : 'Sign In'),
              ),
              const SizedBox(height: 14),
              TextButton(
                key: const Key('toggle_auth_mode_button'),
                onPressed: auth.isLoading ? null : _toggleMode,
                child: Text(
                  _isRegisterMode
                      ? 'Already have an account? Sign In'
                      : 'Need a test account? Register with Firebase',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('login_error_banner'),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
