import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:group_profile_app/data/members_data.dart';
import 'package:group_profile_app/providers/member_provider.dart';
import 'package:group_profile_app/screens/members/member_03_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Member03Screen renders Neo-Brutalist elements and responds to interactions',
      (WidgetTester tester) async {
    // Standard Android screen size (Pixel 7: 412 x 915)
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final member = MembersData.members.firstWhere((m) => m.id == 'member_03');

    await tester.pumpWidget(
      ChangeNotifierProvider<MemberProvider>(
        create: (_) => MemberProvider(),
        child: MaterialApp(
          home: Member03Screen(member: member),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final mainScrollable = find.byType(Scrollable).first;

    // 1. Verify Member 03 core details from resume
    expect(find.textContaining('Nimeshika Sewwandi'.toUpperCase()), findsWidgets);
    expect(find.textContaining('Software Engineering Intern'.toUpperCase()), findsWidgets);
    expect(find.textContaining('Mahiyanganaya, Sri Lanka'), findsWidgets);
    expect(find.textContaining('sewwandinimeshika95@gmail.com'), findsWidgets);

    // 2. Verify Polaroid interaction (tap to tilt)
    final tiltFinder = find.text('⚡ TAP PHOTO TO TILT');
    expect(tiltFinder, findsOneWidget);
    await tester.tap(tiltFinder);
    await tester.pumpAndSettle();

    // 3. Verify Applaud button interaction
    final applaudFinder = find.textContaining('APPLAUD TALENT');
    expect(applaudFinder, findsOneWidget);
    await tester.tap(applaudFinder);
    await tester.pumpAndSettle();
    expect(find.textContaining('Total: 1'), findsOneWidget);

    // 4. Verify Academic Deck PageView swipe
    final nextCardFinder = find.byKey(const Key('edu_next_button'));
    await tester.scrollUntilVisible(nextCardFinder, 200, scrollable: mainScrollable);
    expect(find.textContaining('National Diploma in Information Technology'), findsOneWidget);
    await tester.tap(nextCardFinder);
    await tester.pumpAndSettle();
    expect(find.textContaining('Python for Beginners'), findsOneWidget);

    // 5. Verify Skills Sticker Board
    final skillsHeaderFinder = find.text('SKILLS STICKER PACK');
    await tester.scrollUntilVisible(skillsHeaderFinder, 200, scrollable: mainScrollable);
    expect(find.text('Python'), findsWidgets);
    expect(find.text('React.js'), findsWidgets);
    expect(find.text('MySQL'), findsWidgets);

    // 6. Verify Featured Builds Project PageView
    final projectHeaderFinder = find.text('FEATURED BUILDS');
    await tester.scrollUntilVisible(projectHeaderFinder, 200, scrollable: mainScrollable);
    expect(find.textContaining('SentinelCare'), findsWidgets);

    // 7. Verify Talents and live cheer interaction
    final cheerFinder = find.byKey(const Key('cheer_first_talent'));
    await tester.scrollUntilVisible(cheerFinder, 200, scrollable: mainScrollable);
    expect(find.textContaining('UI/UX & Figma Prototyping'), findsOneWidget);
    await tester.tap(cheerFinder);
    await tester.pumpAndSettle();
    expect(find.textContaining('Cheered (1)'), findsOneWidget);
  });
}
