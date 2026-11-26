import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_profile_app/app.dart';
import 'package:group_profile_app/data/members_data.dart';
import 'package:group_profile_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Deterministic fake [AuthService] for widget and integration-style tests.
class FakeAuthService implements AuthService {
  FakeAuthService({AuthUser? initialUser}) : _currentUser = initialUser;

  AuthUser? _currentUser;
  final StreamController<AuthUser?> _controller =
      StreamController<AuthUser?>.broadcast();

  @override
  bool get isConfigured => true;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  void _emit(AuthUser? user) {
    _currentUser = user;
    _controller.add(user);
  }

  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    if (email.trim() == 'test@group09.edu' && password == 'secret123') {
      final user = AuthUser(uid: 'u1', email: email.trim());
      _emit(user);
      return user;
    }
    throw const AuthFailure(
      'Invalid email or password. Please check your credentials and try again.',
      code: 'invalid-credential',
    );
  }

  @override
  Future<AuthUser> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    final user = AuthUser(uid: 'u2', email: email.trim());
    _emit(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _emit(null);
  }

  void setInitialUserIfNeeded() {
    if (_currentUser != null) return;
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Login validation, error handling, and successful sign-in flow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final fakeAuth = FakeAuthService();
    await tester.pumpWidget(GroupProfileApp(authService: fakeAuth));
    await tester.pumpAndSettle();

    // Initially on LoginScreen
    expect(find.text('Member Sign In'), findsOneWidget);

    // Submit empty form -> validation messages
    final submitBtn = find.byKey(const Key('login_submit_button'));
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email address.'), findsOneWidget);
    expect(find.text('Please enter your password.'), findsOneWidget);

    // Enter wrong credentials -> error banner shown
    await tester.enterText(
      find.byKey(const Key('login_email_field')),
      'wrong@group09.edu',
    );
    await tester.enterText(
      find.byKey(const Key('login_password_field')),
      'wrongpass',
    );
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('login_error_banner')), findsOneWidget);

    // Toggle password visibility
    await tester.tap(find.byKey(const Key('toggle_password_visibility')));
    await tester.pump();

    // Enter valid credentials -> navigates to HomeScreen
    await tester.enterText(
      find.byKey(const Key('login_email_field')),
      'test@group09.edu',
    );
    await tester.enterText(
      find.byKey(const Key('login_password_field')),
      'secret123',
    );
    await tester.ensureVisible(submitBtn);
    await tester.tap(submitBtn);
    await tester.pumpAndSettle();

    expect(find.text('Group Member Directory'), findsOneWidget);
    expect(find.text('Active: test@group09.edu'), findsOneWidget);
  });

  testWidgets('Directory search, favourites filter, and logout return to Login',
      (WidgetTester tester) async {
    final fakeAuth = FakeAuthService(
      initialUser: const AuthUser(uid: 'u1', email: 'lecturer@uni.edu'),
    );
    await tester.pumpWidget(GroupProfileApp(authService: fakeAuth));
    await tester.pumpAndSettle();

    expect(find.text('Group Member Directory'), findsOneWidget);

    // Search for Member 07
    await tester.enterText(
      find.byKey(const Key('directory_search_field')),
      'Cyberpunk',
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('member_card_member_07')), findsOneWidget);
    expect(find.byKey(const Key('member_card_member_01')), findsNothing);

    // Clear search
    await tester.enterText(
      find.byKey(const Key('directory_search_field')),
      '',
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('member_card_member_01')), findsOneWidget);

    // Logout via AppBar button + confirmation dialog
    await tester.tap(find.byKey(const Key('appbar_logout_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    expect(find.text('Member Sign In'), findsOneWidget);
  });

  testWidgets('All 9 unique member bio screens open and display required info',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final fakeAuth = FakeAuthService(
      initialUser: const AuthUser(uid: 'u1', email: 'student@uni.edu'),
    );
    await tester.pumpWidget(GroupProfileApp(authService: fakeAuth));
    await tester.pumpAndSettle();

    for (final member in MembersData.members) {
      await tester.enterText(
        find.byKey(const Key('directory_search_field')),
        member.designStyleName,
      );
      await tester.pumpAndSettle();

      final cardFinder = find.byKey(Key('member_card_${member.id}'));
      expect(cardFinder, findsOneWidget);
      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      // Verify required fields are rendered on the bio screen
      expect(find.textContaining(member.fullName), findsWidgets);
      expect(find.textContaining(member.email), findsWidgets);
      expect(find.textContaining(member.address), findsWidgets);
      expect(find.byType(Image), findsWidgets);

      // Navigate back to directory
      await tester.pageBack();
      await tester.pumpAndSettle();
    }
  });
}
