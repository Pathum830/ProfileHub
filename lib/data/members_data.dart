import 'package:flutter/material.dart';
import 'package:group_profile_app/models/group_member.dart';

/// Centralized directory of all 9 group members.
///
/// ============================================================================
/// IMPORTANT FOR GROUP MEMBERS (CA 02 SUBMISSION):
/// Replace the temporary placeholder details below with your own actual
/// information and place your photograph inside `assets/images/member_0X.png`
/// (or update `photoAsset` to match your image filename).
/// Keep personal addresses general (e.g., City / District) as advised in the
/// assignment brief.
/// ============================================================================
class MembersData {
  MembersData._();

  static const List<GroupMember> members = [
    // =========================================================================
    // MEMBER 01 — Replace with Member 01's actual details
    // Screen file: lib/screens/members/member_01_screen.dart
    // Design Style: Modern Minimalist Profile
    // =========================================================================
    GroupMember(
      id: 'member_01',
      memberNumber: 1,
      studentId: 'STU-2026-001',
      fullName: 'Member 01 (Placeholder Name)',
      shortRole: 'Mobile UI Architect',
      shortDescription:
          'Passionate about clean minimalist interfaces and structured Dart code.',
      address: 'Colombo 07, Western Province (Placeholder City)',
      email: 'member01.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_01.jpg',
      designStyleName: 'Modern Minimalist',
      accentColor: Color(0xFFC85A32),
      bioQuote: 'Simplicity is about subtracting the obvious and adding the meaningful.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'National Secondary School (Placeholder)',
          year: '2020',
          gradeOrStatus: '9 As (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Physical Science Stream (Placeholder)',
          institution: 'National College (Placeholder)',
          year: '2023',
          gradeOrStatus: '3 Passes (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Certificate in Mobile App Foundations (Placeholder)',
          institution: 'Tech Institute (Placeholder)',
          year: '2024',
          gradeOrStatus: 'Distinction',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc (Hons) in Software Engineering (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Teamwork',
          level: 0.92,
          description: 'Collaborates effectively across Git branches and UI reviews.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.88,
          description: 'Writes clear technical documentation and sprint updates.',
        ),
        SoftSkill(
          name: 'Time Management',
          level: 0.90,
          description: 'Delivers modular screen milestones ahead of deadlines.',
        ),
        SoftSkill(
          name: 'Attention to Detail',
          level: 0.94,
          description: 'Focuses on typography rhythm, spacing, and alignment.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Minimalist Photography',
          category: 'Art',
          detail: 'Architectural street framing and monochrome light studies.',
        ),
        SpecialTalent(
          title: 'Badminton',
          category: 'Sports',
          detail: 'Inter-faculty doubles player and weekend club participant.',
        ),
        SpecialTalent(
          title: 'Acoustic Guitar',
          category: 'Music',
          detail: 'Fingerstyle arrangements during study breaks.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 02 — Replace with Member 02's actual details
    // Screen file: lib/screens/members/member_02_screen.dart
    // Design Style: Professional Business Profile
    // =========================================================================
    GroupMember(
      id: 'member_02',
      memberNumber: 2,
      studentId: 'STU-2026-002',
      fullName: 'Member 02 (Placeholder Name)',
      shortRole: 'Systems & Auth Lead',
      shortDescription:
          'Focused on reliable backend integration, Firebase security, and QA.',
      address: 'Kandy, Central Province (Placeholder City)',
      email: 'member02.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_02.jpg',
      designStyleName: 'Professional Business',
      accentColor: Color(0xFF0F2942),
      bioQuote: 'Reliability and clarity turn good prototypes into production software.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Central High School (Placeholder)',
          year: '2019',
          gradeOrStatus: '8 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Commerce & IT (Placeholder)',
          institution: 'Central College (Placeholder)',
          year: '2022',
          gradeOrStatus: '2 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'Diploma in Information Systems (Placeholder)',
          institution: 'Computing Academy (Placeholder)',
          year: '2023',
          gradeOrStatus: 'Merit',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc (Hons) in Information Technology (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Leadership',
          level: 0.93,
          description: 'Coordinates task tracking and release readiness checks.',
        ),
        SoftSkill(
          name: 'Analytical Thinking',
          level: 0.91,
          description: 'Breaks down authentication and validation edge cases.',
        ),
        SoftSkill(
          name: 'Public Speaking',
          level: 0.85,
          description: 'Presents project demos and architecture walkthroughs.',
        ),
        SoftSkill(
          name: 'Conflict Resolution',
          level: 0.87,
          description: 'Keeps group discussions constructive and goal-oriented.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Competitive Chess',
          category: 'Sports',
          detail: 'University chess society member and tactical puzzle solver.',
        ),
        SpecialTalent(
          title: 'Debate & Toastmasters',
          category: 'Speaking',
          detail: 'Participates in structured extempore speaking sessions.',
        ),
        SpecialTalent(
          title: 'Financial Modeling',
          category: 'Hobby',
          detail: 'Builds personal budgeting spreadsheets and tech case studies.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 03 — Replace with Member 03's actual details
    // Screen file: lib/screens/members/member_03_screen.dart
    // Design Style: Creative Portfolio Layout
    // =========================================================================
    GroupMember(
      id: 'member_03',
      memberNumber: 3,
      studentId: 'STU-2026-003',
      fullName: 'Member 03 (Placeholder Name)',
      shortRole: 'Creative Interaction Designer',
      shortDescription:
          'Explores bold color systems, custom animations, and playful layouts.',
      address: 'Galle, Southern Province (Placeholder City)',
      email: 'member03.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_03.jpg',
      designStyleName: 'Creative Portfolio',
      accentColor: Color(0xFFFF4D6D),
      bioQuote: 'Every screen is a canvas for memorable micro-interactions.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Southern Girls/Boys School (Placeholder)',
          year: '2020',
          gradeOrStatus: 'Completed (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Art & Design / ICT (Placeholder)',
          institution: 'Coastal College (Placeholder)',
          year: '2023',
          gradeOrStatus: 'Completed (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'UI/UX Visual Design Bootcamp (Placeholder)',
          institution: 'Design Studio School (Placeholder)',
          year: '2024',
          gradeOrStatus: 'Top Portfolio',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc in Interactive Media & Computing (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Creative Problem Solving',
          level: 0.95,
          description: 'Turns complex requirements into intuitive visual stories.',
        ),
        SoftSkill(
          name: 'Empathy',
          level: 0.90,
          description: 'Designs accessible layouts for diverse screen sizes.',
        ),
        SoftSkill(
          name: 'Adaptability',
          level: 0.89,
          description: 'Iterates rapidly based on usability feedback.',
        ),
        SoftSkill(
          name: 'Teamwork',
          level: 0.88,
          description: 'Shares reusable assets and style ideas with teammates.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Digital Illustration',
          category: 'Art',
          detail: 'Character sketching, vector posters, and editorial covers.',
        ),
        SpecialTalent(
          title: 'Origami & Paper Craft',
          category: 'Hobby',
          detail: 'Modular geometric paper sculptures.',
        ),
        SpecialTalent(
          title: 'Ukulele',
          category: 'Music',
          detail: 'Indie acoustic covers and rhythm composition.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 04 — Replace with Member 04's actual details
    // Screen file: lib/screens/members/member_04_screen.dart
    // Design Style: Gradient Profile Design
    // =========================================================================
    GroupMember(
      id: 'member_04',
      memberNumber: 4,
      studentId: 'STU-2026-004',
      fullName: 'Member 04 (Placeholder Name)',
      shortRole: 'Flutter Animation Specialist',
      shortDescription:
          'Crafts fluid glassmorphic UIs, gradients, and responsive mobile flows.',
      address: 'Negombo, Western Province (Placeholder City)',
      email: 'member04.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_04.jpg',
      designStyleName: 'Gradient & Glass',
      accentColor: Color(0xFF7C3AED),
      bioQuote: 'Light, depth, and motion guide the user without extra words.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'St. Mary/Joseph High School (Placeholder)',
          year: '2020',
          gradeOrStatus: '8 As (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Combined Maths & ICT (Placeholder)',
          institution: 'West Coast College (Placeholder)',
          year: '2023',
          gradeOrStatus: '2 Bs, 1 C (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Cross-Platform Dart & Flutter Certificate (Placeholder)',
          institution: 'Online Tech Academy (Placeholder)',
          year: '2025',
          gradeOrStatus: 'Completed',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Collaboration',
          level: 0.90,
          description: 'Pairs smoothly on state management and widget composition.',
        ),
        SoftSkill(
          name: 'Active Listening',
          level: 0.87,
          description: 'Captures peer feedback during design critiques.',
        ),
        SoftSkill(
          name: 'Self-Motivation',
          level: 0.93,
          description: 'Explores new Flutter rendering APIs independently.',
        ),
        SoftSkill(
          name: 'Time Management',
          level: 0.86,
          description: 'Balances coursework, labs, and group milestones.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Swimming',
          category: 'Sports',
          detail: 'Freestyle lap swimmer and coastal lifesaving enthusiast.',
        ),
        SpecialTalent(
          title: 'Electronic Music Production',
          category: 'Music',
          detail: 'Ambient synth soundscapes and lo-fi beats.',
        ),
        SpecialTalent(
          title: 'Motion Graphics',
          category: 'Art',
          detail: 'Short kinetic typography loops.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 05 — Replace with Member 05's actual details
    // Screen file: lib/screens/members/member_05_screen.dart
    // Design Style: Timeline-Based Biography
    // =========================================================================
    GroupMember(
      id: 'member_05',
      memberNumber: 5,
      studentId: 'STU-2026-005',
      fullName: 'Member 05 (Placeholder Name)',
      shortRole: 'Documentation & State Lead',
      shortDescription:
          'Structures learning journeys, chronological data, and Provider state.',
      address: 'Kurunegala, North Western Province (Placeholder City)',
      email: 'member05.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_05.jpg',
      designStyleName: 'Timeline Biography',
      accentColor: Color(0xFF1B6B5A),
      bioQuote: 'Every milestone shapes the engineer we become tomorrow.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Wayamba National School (Placeholder)',
          year: '2019',
          gradeOrStatus: '9 As (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Biological / Tech Stream (Placeholder)',
          institution: 'North Western College (Placeholder)',
          year: '2022',
          gradeOrStatus: '3 Bs (Sample)',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'Diploma in Software Development (Placeholder)',
          institution: 'National ICT Institute (Placeholder)',
          year: '2023',
          gradeOrStatus: 'Distinction',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc (Hons) in Computer Science (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Organization',
          level: 0.94,
          description: 'Maintains clean project timelines and README records.',
        ),
        SoftSkill(
          name: 'Mentoring',
          level: 0.88,
          description: 'Helps peers debug Git merge conflicts and layout bugs.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.91,
          description: 'Writes concise, structured specifications.',
        ),
        SoftSkill(
          name: 'Patience',
          level: 0.90,
          description: 'Calmly troubleshoots tricky async state flows.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Creative Writing',
          category: 'Hobby',
          detail: 'Short fiction essays and technical reflection journals.',
        ),
        SpecialTalent(
          title: 'Table Tennis',
          category: 'Sports',
          detail: 'Fast-paced doubles matches in the student union hall.',
        ),
        SpecialTalent(
          title: 'Botanical Sketching',
          category: 'Art',
          detail: 'Ink and watercolor studies of native leaves.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 06 — Replace with Member 06's actual details
    // Screen file: lib/screens/members/member_06_screen.dart
    // Design Style: Magazine-Style Profile
    // =========================================================================
    GroupMember(
      id: 'member_06',
      memberNumber: 6,
      studentId: 'STU-2026-006',
      fullName: 'Member 06 (Placeholder Name)',
      shortRole: 'Editorial & Typography Lead',
      shortDescription:
          'Loves print-inspired mobile grids, expressive headings, and storytelling.',
      address: 'Matara, Southern Province (Placeholder City)',
      email: 'member06.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_06.jpg',
      designStyleName: 'Magazine Editorial',
      accentColor: Color(0xFFB91C1C),
      bioQuote: 'Great typography gives digital screens the poise of print.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Southern Model School (Placeholder)',
          year: '2020',
          gradeOrStatus: '8 As, 1 C (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Languages & ICT (Placeholder)',
          institution: 'Matara Central College (Placeholder)',
          year: '2023',
          gradeOrStatus: '2 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Editorial & Digital Publishing Certificate (Placeholder)',
          institution: 'Media Institute (Placeholder)',
          year: '2024',
          gradeOrStatus: 'Merit',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Storytelling',
          level: 0.94,
          description: 'Frames user journeys with compelling visual hierarchy.',
        ),
        SoftSkill(
          name: 'Critical Thinking',
          level: 0.89,
          description: 'Evaluates readability and contrast on small viewports.',
        ),
        SoftSkill(
          name: 'Presentation',
          level: 0.92,
          description: 'Leads slide decks and live project demonstrations.',
        ),
        SoftSkill(
          name: 'Teamwork',
          level: 0.88,
          description: 'Reviews copy consistency across all screens.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Classical Violin',
          category: 'Music',
          detail: 'Performed in school chamber ensembles for 6 years.',
        ),
        SpecialTalent(
          title: 'Editorial Photography',
          category: 'Art',
          detail: 'Portrait lighting and magazine-style photo essays.',
        ),
        SpecialTalent(
          title: 'Cycling',
          category: 'Sports',
          detail: 'Early morning coastal road rides.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 07 — Replace with Member 07's actual details
    // Screen file: lib/screens/members/member_07_screen.dart
    // Design Style: Dark Theme Profile
    // =========================================================================
    GroupMember(
      id: 'member_07',
      memberNumber: 7,
      studentId: 'STU-2026-007',
      fullName: 'Member 07 (Placeholder Name)',
      shortRole: 'Security & Testing Engineer',
      shortDescription:
          'Builds resilient dark-mode tools, widget tests, and terminal interfaces.',
      address: 'Jaffna, Northern Province (Placeholder City)',
      email: 'member07.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_07.jpg',
      designStyleName: 'Dark Cyberpunk',
      accentColor: Color(0xFF00F5D4),
      bioQuote: 'Clean tests and strong validation keep midnight builds calm.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Northern High School (Placeholder)',
          year: '2020',
          gradeOrStatus: '9 As (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Physical Science (Placeholder)',
          institution: 'Jaffna College (Placeholder)',
          year: '2023',
          gradeOrStatus: '2 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Cybersecurity & Mobile Testing Essentials (Placeholder)',
          institution: 'Tech Security Lab (Placeholder)',
          year: '2025',
          gradeOrStatus: 'Honors',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc (Hons) in Cyber & Software Systems (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Problem Solving',
          level: 0.95,
          description: 'Isolates edge-case crashes and async race conditions.',
        ),
        SoftSkill(
          name: 'Resilience',
          level: 0.91,
          description: 'Stays methodical during complex debugging sessions.',
        ),
        SoftSkill(
          name: 'Technical Writing',
          level: 0.87,
          description: 'Documents testing steps and Firebase setup guides.',
        ),
        SoftSkill(
          name: 'Team Support',
          level: 0.90,
          description: 'Helps group mates run static analysis and tests.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Capture The Flag (CTF)',
          category: 'Tech Hobby',
          detail: 'Solves cryptography and logic challenges on weekends.',
        ),
        SpecialTalent(
          title: 'Mechanical Keyboards',
          category: 'Hobby',
          detail: 'Custom keycap layouts and tactile switch modding.',
        ),
        SpecialTalent(
          title: 'Track & Field Sprinting',
          category: 'Sports',
          detail: '100m and 200m university athletics participant.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 08 — Replace with Member 08's actual details
    // Screen file: lib/screens/members/member_08_screen.dart
    // Design Style: Card-Based Profile
    // =========================================================================
    GroupMember(
      id: 'member_08',
      memberNumber: 8,
      studentId: 'STU-2026-008',
      fullName: 'Member 08 (Placeholder Name)',
      shortRole: 'Responsive Layout Engineer',
      shortDescription:
          'Designs modular Bento card grids that adapt cleanly across screen sizes.',
      address: 'Gampaha, Western Province (Placeholder City)',
      email: 'member08.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_08.jpg',
      designStyleName: 'Bento Card Grid',
      accentColor: Color(0xFF0D9488),
      bioQuote: 'Modular cards make complex information effortless to scan.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Gampaha Secondary School (Placeholder)',
          year: '2020',
          gradeOrStatus: '8 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Engineering Technology (Placeholder)',
          institution: 'District Tech College (Placeholder)',
          year: '2023',
          gradeOrStatus: '3 Passes (Sample)',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'Higher Diploma in Mobile Computing (Placeholder)',
          institution: 'IT Polytechnic (Placeholder)',
          year: '2024',
          gradeOrStatus: 'Merit',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Collaboration',
          level: 0.92,
          description: 'Coordinates layout breakpoints across Android devices.',
        ),
        SoftSkill(
          name: 'Creativity',
          level: 0.88,
          description: 'Balances playful chips with crisp information cards.',
        ),
        SoftSkill(
          name: 'Dependability',
          level: 0.91,
          description: 'Consistently finishes assigned PRs with zero lints.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.87,
          description: 'Clarifies user flows early with wireframes.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Cricket',
          category: 'Sports',
          detail: 'All-rounder in inter-batch weekend leather-ball matches.',
        ),
        SpecialTalent(
          title: 'Culinary Baking',
          category: 'Hobby',
          detail: 'Experiments with sourdough and artisan pastries.',
        ),
        SpecialTalent(
          title: '3D Paper Modeling',
          category: 'Art',
          detail: 'Low-poly papercraft figurines.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 09 — Replace with Member 09's actual details
    // Screen file: lib/screens/members/member_09_screen.dart
    // Design Style: Modern Dashboard-Style Profile
    // =========================================================================
    GroupMember(
      id: 'member_09',
      memberNumber: 9,
      studentId: 'STU-2026-009',
      fullName: 'Member 09 (Placeholder Name)',
      shortRole: 'Analytics & Product Lead',
      shortDescription:
          'Transforms profile metrics and academic milestones into interactive dashboards.',
      address: 'Anuradhapura, North Central Province (Placeholder City)',
      email: 'member09.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_09.jpg',
      designStyleName: 'Modern Dashboard',
      accentColor: Color(0xFF2563EB),
      bioQuote: 'Good dashboards turn raw facts into actionable insight at a glance.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Central Valley School (Placeholder)',
          year: '2019',
          gradeOrStatus: '8 As, 1 B (Sample)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level — Combined Maths & Physics (Placeholder)',
          institution: 'North Central College (Placeholder)',
          year: '2022',
          gradeOrStatus: '2 Bs, 1 C (Sample)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Data Visualization & Flutter Charts (Placeholder)',
          institution: 'Analytics Guild (Placeholder)',
          year: '2024',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Degree',
          title: 'BSc (Hons) in Data & Mobile Systems (Ongoing)',
          institution: 'University Campus (Placeholder)',
          year: '2024 – Present',
          gradeOrStatus: 'Year 2',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Strategic Planning',
          level: 0.93,
          description: 'Aligns GitHub milestones and presentation checklists.',
        ),
        SoftSkill(
          name: 'Leadership',
          level: 0.89,
          description: 'Facilitates sprint retrospectives and code reviews.',
        ),
        SoftSkill(
          name: 'Decision Making',
          level: 0.90,
          description: 'Prioritizes core assignment criteria and UX polish.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.88,
          description: 'Summarizes complex status metrics clearly.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Custom Data Art',
          category: 'Art',
          detail: 'Generative geometric patterns using math & canvas.',
        ),
        SpecialTalent(
          title: 'Basketball',
          category: 'Sports',
          detail: 'Point guard in campus evening leagues.',
        ),
        SpecialTalent(
          title: 'Piano & Synth',
          category: 'Music',
          detail: 'Improvised jazz chord progressions.',
        ),
      ],
    ),
  ];
}
