# Group 09 • BioHub — Mobile Communication CA 02

A complete Flutter group profile mobile application built for **Mobile Communication — Continuous Assessment 02 (CA 02)**. After signing in via **Firebase Authentication (Email & Password)**, users can browse all **9 group members** in a responsive directory and open **9 completely distinct, individually designed member biography screens**.

---

## Key Features

- **Firebase Authentication (`firebase_auth`)**
  - Email & password sign-in and optional test-account registration.
  - Client-side form validation, show/hide password toggle, loading spinner, and friendly Firebase error messages.
  - Persistent authentication sessions (`authStateChanges`) and protected routes via `AuthGate`.
  - Confirmation-guarded logout returning directly to the login screen.
- **Responsive Home / Member Directory**
  - Displays all 9 group members with photographs, full names, roles, descriptions, and design style tags.
  - Live search across names, roles, soft skills, talents, qualifications, cities, and design styles.
  - Grid / List view toggle, Favourites filter, and Light / Dark theme switcher.
- **9 Unique Member Bio Screens**
  - Every member screen uses an original layout, palette, typography treatment, and widget composition while presenting all 7 required CA 02 fields:
    1. Full Name
    2. Address (kept general, e.g., city/district)
    3. Email Address
    4. Academic Qualifications (O/L, A/L, Certificates, Diplomas, Degree)
    5. Member Photograph (loaded from `assets/images/`)
    6. Soft Skills
    7. Special Talents / Hobbies
- **State Management (`provider` + `setState`)**
  - `AuthProvider` for auth state, loading state, errors, and remembered email.
  - `MemberProvider` for directory search, favourites, endorsements, grid/list mode, and theme mode.
  - Screen-local `setState` interactions (filter chips, tabs, expandable sections, carousels, accent switchers).

---

## Project Architecture

```text
lib/
├── main.dart                         # App bootstrap & safe Firebase initialization
├── app.dart                          # MultiProvider, MaterialApp, theme & auth listener
├── firebase_options.dart             # Template FlutterFire options (replace via flutterfire configure)
├── constants/
│   ├── app_colors.dart               # Shared color tokens
│   ├── app_constants.dart            # App titles, breakpoints, preference keys
│   └── app_theme.dart                # Material 3 Light & Dark themes
├── models/
│   └── group_member.dart             # GroupMember, AcademicQualification, SoftSkill, SpecialTalent
├── data/
│   └── members_data.dart             # Centralized placeholder data for all 9 members
├── services/
│   ├── firebase_initializer.dart     # Safe Firebase initialization wrapper
│   └── auth_service.dart             # AuthService contract + FirebaseAuthService
├── providers/
│   ├── auth_provider.dart            # Authentication & session state
│   └── member_provider.dart          # Directory search, favourites, theme & view state
├── routes/
│   └── app_routes.dart               # Auth-guarded routes & animated transitions
├── widgets/
│   ├── auth_gate.dart                # Route guard protecting authenticated screens
│   ├── favorite_button.dart          # Animated favourite toggle button
│   └── member_photo.dart             # Local asset image loader with graceful fallback
└── screens/
    ├── login/
    │   └── login_screen.dart         # Firebase email/password login & registration UI
    ├── home/
    │   └── home_screen.dart          # Responsive 9-member directory & search
    └── members/
        ├── member_01_screen.dart     # 01: Modern Minimalist Profile
        ├── member_02_screen.dart     # 02: Professional Business Profile
        ├── member_03_screen.dart     # 03: Creative Portfolio Layout
        ├── member_04_screen.dart     # 04: Gradient & Glassmorphic Design
        ├── member_05_screen.dart     # 05: Timeline-Based Biography
        ├── member_06_screen.dart     # 06: Magazine-Style Profile
        ├── member_07_screen.dart     # 07: Dark Theme Profile
        ├── member_08_screen.dart     # 08: Card-Based (Bento) Profile
        └── member_09_screen.dart     # 09: Modern Dashboard-Style Profile

assets/
└── images/
    └── member_01.jpg ... member_09.jpg
```

---

## Group Members & Screen Contributions (Replace Placeholders Before Submission)

> **Instructions for Group Members:** Update your personal placeholder entry in [`lib/data/members_data.dart`](lib/data/members_data.dart), replace your image in `assets/images/member_0X.jpg`, and fill in your real Name and Student ID in the table below.

| # | Name (Placeholder) | Student ID | Bio Screen File | Unique Design Style |
|---|---|---|---|---|
| 01 | Member 01 (Replace Name) | `STU-2026-001` | `lib/screens/members/member_01_screen.dart` | Modern Minimalist (`SliverAppBar`, hairline dividers, `ChoiceChip` filter) |
| 02 | Member 02 (Replace Name) | `STU-2026-002` | `lib/screens/members/member_02_screen.dart` | Professional Business (`NestedScrollView`, `TabBarView`, `Table`, copy email) |
| 03 | Member 03 (Replace Name) | `STU-2026-003` | `lib/screens/members/member_03_screen.dart` | Creative Portfolio (Neo-brutalist Polaroid `Transform.rotate`, `PageView`, applause) |
| 04 | Member 04 (Replace Name) | `STU-2026-004` | `lib/screens/members/member_04_screen.dart` | Gradient & Glassmorphic (`BackdropFilter` blur, horizontal cards, `ExpansionTile`) |
| 05 | Member 05 (Replace Name) | `STU-2026-005` | `lib/screens/members/member_05_screen.dart` | Timeline Biography (`ClipPath` wave, interactive timeline, `AnimatedCrossFade`) |
| 06 | Member 06 (Replace Name) | `STU-2026-006` | `lib/screens/members/member_06_screen.dart` | Magazine Editorial (Cover hero, pull-quote, drop-cap lead, inverted feature spread) |
| 07 | Member 07 (Replace Name) | `STU-2026-007` | `lib/screens/members/member_07_screen.dart` | Dark Cyberpunk (Obsidian theme, hexagon `ClipPath`, `SegmentedButton`, monospace) |
| 08 | Member 08 (Replace Name) | `STU-2026-008` | `lib/screens/members/member_08_screen.dart` | Card-Based Bento Grid (`FilterChip` skill inspector, `AnimatedSize`, Bento grid) |
| 09 | Member 09 (Replace Name) | `STU-2026-009` | `lib/screens/members/member_09_screen.dart` | Modern Dashboard (KPI tiles, `CustomPaint` ring chart, `DataTable`, accent switcher) |

---

## Test Login for Lecturer (Firebase Authentication)

> **Security Note:** Do **not** commit personal passwords or private API service keys to GitHub. Create a dedicated lecturer test account in **Firebase Console -> Authentication -> Users** (with **Email/Password** provider enabled) and document that dedicated test login here before final Moodle submission:

- **Test Email:** `lecturer-test@example.com` *(Create this user in your Firebase Console)*
- **Test Password:** *(Set in Firebase Console Authentication > Users and add the test credential for the lecturer before final submission)*

---

## Project Setup Instructions

### Prerequisites
- Flutter SDK (`>= 3.47.x` / Dart `>= 3.13.x`)
- Android Studio / VS Code with Android SDK (minSdk 23+)
- A Firebase project with **Email/Password Authentication** enabled

### 1. Clone & Install Dependencies
```bash
git clone <your-github-repo-url>
cd mobile
flutter pub get
```

### 2. Connect Your Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/) and create a project (e.g., `mobile-comm-ca02`).
2. Navigate to **Build -> Authentication -> Sign-in method** and enable **Email/Password**.
3. Under **Authentication -> Users**, add a test user for your group and lecturer.
4. Configure FlutterFire from the project root:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   This updates `lib/firebase_options.dart` and places `android/app/google-services.json` automatically.
5. *(Manual Android fallback)* If not using `flutterfire configure`, download `google-services.json` for Android package `com.mobilecomm.ca02.group_profile_app` into `android/app/google-services.json`.

### 3. Run the App
```bash
flutter run
```

---

## Testing & Static Analysis

Run static analysis:
```bash
flutter analyze
```

Run automated widget & flow tests:
```bash
flutter test
```
