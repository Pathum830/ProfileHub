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
    // MEMBER 01 — Pathum Siriwardhana
    // Screen file: lib/screens/members/member_01_screen.dart
    // Design Style: Modern Minimalist Profile
    // =========================================================================
    GroupMember(
      id: 'member_01',
      memberNumber: 1,
      studentId: 'STU-2026-001 (Placeholder)',
      fullName: 'Pathum Siriwardhana',
      shortRole: 'Intern DevOps Engineer',
      shortDescription: 'IT student at ITUM focused on DevOps engineering, cloud infrastructure, Linux, Docker, and CI/CD automation.',
      address: 'Badulla, Sri Lanka',
      email: 'pathumsiriwardhana86@gmail.com',
      photoAsset: 'assets/images/member_01.jpg',
      designStyleName: 'Modern Minimalist',
      accentColor: Color(0xFF9C7A54),
      bioQuote: 'Helping deliver reliable software through efficient build, test, and deployment workflows.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Secondary School Name (Placeholder)',
          year: 'YYYY (Placeholder)',
          gradeOrStatus: 'Results (Placeholder)',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level Examination (Placeholder)',
          institution: 'B/Dharmadutha Collage (Placeholder)',
          year: '2017 (Placeholder)',
          gradeOrStatus: 'A6 B2 C1 (Placeholder)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Python for Beginners',
          institution: 'University of Moratuwa',
          year: '2025',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Cloud Computing Fundamentals',
          institution: 'IBM SkillsBuild',
          year: '2026',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Google AI Essentials',
          institution: 'Google',
          year: '2026',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Diploma',
          title:
              'National Diploma in Technology (NDT) – Information Technology',
          institution: 'Institute of Technology, University of Moratuwa (ITUM), Sri Lanka',
          year: '2024 – Present',
          gradeOrStatus: 'Ongoing',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Team Collaboration',
          level: 0.85,
          description: 'Collaborated in academic group projects using Git and GitHub workflows (level placeholder).',
        ),
        SoftSkill(
          name: 'Communication (Placeholder)',
          level: 0.80,
          description:
              'Placeholder — update with verified personal soft skill details.',
        ),
        SoftSkill(
          name: 'Time Management (Placeholder)',
          level: 0.80,
          description:
              'Placeholder — update with verified personal soft skill details.',
        ),
        SoftSkill(
          name: 'Adaptability (Placeholder)',
          level: 0.82,
          description:
              'Placeholder — update with verified personal soft skill details.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Special Talent 01 (Placeholder)',
          category: 'Placeholder',
          detail:
              'Add your verified artistic, creative, or technical talent here.',
        ),
        SpecialTalent(
          title: 'Sport / Activity 02 (Placeholder)',
          category: 'Placeholder',
          detail: 'Add your verified sports or extracurricular activity here.',
        ),
        SpecialTalent(
          title: 'Personal Hobby 03 (Placeholder)',
          category: 'Placeholder',
          detail:
              'Add your verified music, reading, or personal interest here.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 02 — Chathupama Thathsarani
    // Screen file: lib/screens/members/member_02_screen.dart
    // Design Style: Professional Corporate Profile
    // =========================================================================
    GroupMember(
      id: 'member_02',
      memberNumber: 2,
      studentId: 'NDT/IT/2025/002 (Placeholder)',
      fullName: 'Chathupama Thathsarani',
      shortRole: 'Software Engineer | Full-Stack Developer',
      shortDescription:
          'Detail-oriented Information Technology undergraduate (NDT) at the Institute of Technology, University of Moratuwa, passionate about Software Engineering and System Architecture. Skilled in modern stacks including React, Flutter, Java, Python, PHP, MongoDB, and MySQL.',
      address: 'Moratuwa, Sri Lanka',
      email: 'chathupamathathsarani51@gmail.com',
      photoAsset: 'assets/images/member_02.jpg',
      designStyleName: 'Professional Corporate Profile',
      accentColor: Color(0xFF0F2942),
      bioQuote:
          'Proven ability to translate complex requirements into clean, maintainable code and optimized database solutions, backed by practical exposure to enterprise data workflows.',
      qualifications: [
        AcademicQualification(
          level: 'National Diploma',
          title: 'National Diploma in Technology (NDT) – Information Technology',
          institution:
              'Institute of Technology, University of Moratuwa (ITUM)',
          year: '2025 – 2027 (Expected)',
          gradeOrStatus: 'Undergraduate (Ongoing)',
        ),
        AcademicQualification(
          level: 'Certification',
          title: 'JavaScript Essentials',
          institution: 'Cisco Networking Academy',
          year: '2026',
          gradeOrStatus: 'Certified',
        ),
        AcademicQualification(
          level: 'Certification',
          title: 'Python for Beginners',
          institution:
              'Centre for Open & Distance Learning (CODL), University of Moratuwa',
          year: '2026',
          gradeOrStatus: 'Certified',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Certificate Course in English',
          institution: 'The Open University of Sri Lanka (OUSL)',
          year: '2024',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Advanced Certificate',
          title: 'Advanced Certificate Course in Cyber Security & Networking',
          institution: 'NextGen Institute, Sri Lanka',
          year: '2023',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'G.C.E. Advanced Level Examination (Placeholder)',
          institution: 'H/Vijayaba National School, Hungama (Placeholder)',
          year: '2021 (Placeholder)',
          gradeOrStatus: 'B-1 C-2 (Placeholder)',
        ),
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'G.C.E. Ordinary Level Examination (Placeholder)',
          institution: 'H/Vijayaba National School, Hungama (Placeholder)',
          year: '2018 (Placeholder)',
          gradeOrStatus: 'A-3 B-5 C-1 (Placeholder)',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Problem Solving',
          level: 0.95,
          description:
              'Proven ability to translate complex software requirements into clean, maintainable code and optimized database solutions.',
          name: 'Leadership',
          level: 0.93,
          description:
              'Coordinates task tracking and release readiness checks.',
        ),
        SoftSkill(
          name: 'Teamwork & Collaboration',
          level: 0.92,
          description:
              'Active collaborator in multi-developer sprint workflows, code reviews, and Git/GitHub repository management.',
        ),
        SoftSkill(
          name: 'Adaptability',
          level: 0.88,
          description:
              'Swiftly masters emerging tech stacks across web (React), mobile (Flutter), and backend systems (Node.js).',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.85,
          description:
              'Articulate technical and client communication cultivated through banking customer service and academic presentations.',
          name: 'Conflict Resolution',
          level: 0.87,
          description:
              'Keeps group discussions constructive and goal-oriented.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Full-Stack & System Architecture',
          category: 'Technical Excellence',
          detail:
              'Architects scalable solutions like Serva (ITUM infrastructure management) and WedEase (AI wedding platform) using React, Flutter, Node.js, and SQL/NoSQL.',
        ),
        SpecialTalent(
          title: 'Banking Operations & Digital Workflows',
          category: 'Industry Experience',
          detail:
              'Professional banking internship at Hatton National Bank (HNB) executing transaction workflows, digital banking software, and data accuracy audits.',
        ),
        SpecialTalent(
          title: 'Secure Systems & Cyber Security',
          category: 'Security & Innovation',
          detail:
              'Built secure web-based automated voting systems with audit trails and completed advanced cyber security & networking certification.',
          title: 'Financial Modeling',
          category: 'Hobby',
          detail:
              'Builds personal budgeting spreadsheets and tech case studies.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 03 — Nimeshika Sewwandi
    // Screen file: lib/screens/members/member_03_screen.dart
    // Design Style: Creative Portfolio / Neo-Brutalist
    // =========================================================================
    GroupMember(
      id: 'member_03',
      memberNumber: 3,


      studentId: 'ITUM/IT/2025/003 (Placeholder)',
      fullName: 'Nimeshika Sewwandi',
      shortRole: 'Software Engineering Intern',
      shortDescription:
          'Motivated IT student at ITUM skilled in programming, web development, and UI/UX design, passionate about building impactful digital solutions.',
      address: 'Mahiyanganaya, Sri Lanka',
      email: 'sewwandinimeshika95@gmail.com',
 main
      photoAsset: 'assets/images/member_03.jpg',
      designStyleName: 'Creative Portfolio / Neo-Brutalist',
      accentColor: Color(0xFFFFDF00),
      bioQuote:
          'Motivated and hardworking IT student with basic knowledge of programming, web development and graphic design. A quick learner with teamwork and communication skills, eager to learn, gain practical experience and grow professionally.',
      qualifications: [
        AcademicQualification(
          level: 'Diploma',
          title: 'National Diploma in Information Technology (NDIT)',
          institution:
              'Institute of Technology, University of Moratuwa (ITUM)',
          year: '2025 – 2027',
          gradeOrStatus: 'Current GPA: 2.51 / 4.00 (Ongoing)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Python for Beginners',
          institution: 'CODL, University of Moratuwa',
          year: '2025',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Web Development',
          institution: 'CODL, University of Moratuwa',
          year: '2025',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Foundation English Course',
          institution: 'Kekirawa English Academy',
          year: '2024',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level Examination (Placeholder)',
          institution: 'Secondary School, Mahiyanganaya (Placeholder)',
          year: '2023 (Placeholder)',
          gradeOrStatus: 'Completed (Placeholder)',
        ),
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination (Placeholder)',
          institution: 'Secondary School, Mahiyanganaya (Placeholder)',
          year: '2020 (Placeholder)',
          gradeOrStatus: 'Completed (Placeholder)',
        ),
      ],
      softSkills: [
        SoftSkill(

          name: 'Problem Solving',
          level: 0.92,
          description:
              'Analytical debugging and algorithmic problem solving across software projects.',
 main
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.88,
          description:
              'Clear articulation and presentation skills in bilingual English & Sinhala team environments.',
        ),
        SoftSkill(
          name: 'Teamwork',
          level: 0.94,
          description:
              'Collaborative group project development using Git and GitHub workflows.',
        ),
        SoftSkill(
          name: 'Adaptability',
          level: 0.90,
          description:
              'Quick learner transitioning swiftly across emerging technologies and toolsets.',
        ),
        SoftSkill(
          name: 'Time Management',
          level: 0.86,
          description:
              'Balancing academic diploma coursework with hands-on project deliverables.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'UI/UX & Figma Prototyping',
          category: 'Design & Creativity',
          detail:
              'Crafting user-centric wireframes, bold interactive mockups, and creative visual design systems.',
        ),
        SpecialTalent(
          title: 'IoT Health Innovation',
          category: 'Technology & Hardware',
          detail:
              'Designed & developed SentinelCare smart medical hand band system with sensors and web dashboard.',
        ),
        SpecialTalent(
          title: 'Full-Stack Web Development',
          category: 'Engineering & Coding',
          detail:
              'Building responsive real-time web applications with React.js, Node.js, PHP, and MySQL.',
        ),
        SpecialTalent(
          title: 'Digital Illustration & Poster Art',
          category: 'Creative Art',
          detail:
              'Creating expressive sketches, neo-brutalist vector illustrations, and digital graphics.',
        ),
        SpecialTalent(
          title: 'Tech Exploration & Gaming',
          category: 'Personal Passion',
          detail:
              'Enthusiastic about exploring modern frameworks, developer communities, and logic puzzle games.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 04 — Vichakshi Shashiprabha
    // Screen file: lib/screens/members/member_04_screen.dart
    // Design Style: Gradient Glassmorphism
    // =========================================================================
    GroupMember(
      id: 'member_04',
      memberNumber: 4,
      studentId: 'STU-2026-004 (Placeholder)',
      fullName: 'Vichakshi Shashiprabha',
      shortRole: 'UI/UX Designer & IT Undergraduate',
      shortDescription: 'Motivated and creative IT student specializing in UI/UX design, focused on crafting intuitive, user-friendly, and visually appealing digital interfaces.',
      address: 'Homagama / Colombo',
      email: 'vichakshi245@gmail.com',
      photoAsset: 'assets/images/member_04.jpg',
      designStyleName: 'Gradient Glassmorphism',
      accentColor: Color(0xFF7C3AED),
      bioQuote: 'Passionate about creating intuitive, user-friendly, and visually appealing digital interfaces.',
      qualifications: [
        AcademicQualification(
          level: 'Diploma',
          title: 'National Diploma in Information Technology',
          institution: 'ITUM',
          year: '2025 – Present',
          gradeOrStatus: 'Ongoing',
        ),
        AcademicQualification(
          level: 'NVQ Level 4',
          title: 'ICTT NVQ Level 4 Course',
          institution: 'VTA, Maharagama',
          year: '2022 – 2023',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'Diploma in Graphic Design',
          institution: 'Sipway Campus, Kurunegala',
          year: '2023',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'G.C.E. A/L Examination',
          institution: 'Dharmapala Vidyalaya, Pannipitiya',
          year: '2021 (2022)',
          gradeOrStatus: 'Results (Placeholder)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Introduction to Figma',
          institution: 'Simplilearn SkillUp',
          year: 'Oct 2026',
          gradeOrStatus: 'Certified',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Introduction to Adobe XD',
          institution: 'Simplilearn SkillUp',
          year: 'Nov 2026',
          gradeOrStatus: 'Certified',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Design Thinking for Beginners',
          institution: 'Simplilearn SkillUp',
          year: 'Oct 2026',
          gradeOrStatus: 'Certified',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Teamwork',
          level: 0.90,
          description: 'Collaborates with developers on group projects like SeettuManager to integrate React layouts with backend APIs (level placeholder).',
        ),
        SoftSkill(
          name: 'Rapid Learning',
          level: 0.88,
          description: 'Continuously upskills across UI/UX design tools, design thinking, and modern web technologies (level placeholder).',
        ),
        SoftSkill(
          name: 'Problem-Solving',
          level: 0.87,
          description: 'Turns user registration, payment, and tracking requirements into clean, intuitive interface flows (level placeholder).',
        ),
        SoftSkill(
          name: 'Event Coordination',
          level: 0.89,
          description: 'Organizes student activities and martial arts training built on prefectship and coaching experience (level placeholder).',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.90,
          description: 'Aligns clearly with cross-functional project teams, students, and academic stakeholders (level placeholder).',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Karate Coaching',
          category: 'Sports',
          detail: 'Karate Coach at Ilma International Girls School (May 2024 – Present); holds NISS Coaching Licence, SLKF Coach ID, and D Grade Instructor status; 3rd Place at Sri Lanka School Karate Championship 2018 & Colombo District Championship 2017 (Female Kata).',
        ),
        SpecialTalent(
          title: 'UI/UX & Graphic Design',
          category: 'Creative Design',
          detail: 'Designs mobile and web experiences using Figma, Adobe XD, Photoshop, Illustrator, and CorelDRAW; designed complete interface screens for SeettuManager.',
        ),
        SpecialTalent(
          title: 'Frontend & Visual Prototyping',
          category: 'Technology',
          detail: 'Builds interactive web views with HTML5, CSS3, React.js, and Power BI, bridging visual design with functional implementation.',
        ),
        SpecialTalent(
          title: 'Student Leadership & Prefectship',
          category: 'Leadership',
          detail: 'Served as Senior Prefect (2018) and Junior Prefect (2017) at Homagama President’s College, and worked as a Trainee at ITUM Division of Interdisciplinary Studies.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 05 — Chamodi Madhushani
    // Screen file: lib/screens/members/member_05_screen.dart
    // Design Style: Personal Journey Timeline
    // =========================================================================
    GroupMember(
      id: 'member_05',
      memberNumber: 5,

      studentId: '23IT0536',
      fullName: 'Chamodi Madhushani',
      shortRole: 'Software Engineer • Mobile App Dev',
      shortDescription:
          'Motivated IT undergraduate at the Institute of Technology, University of Moratuwa, passionate about Full-Stack and Mobile Application Development.',
      address: 'Horampalla, Sri Lanka',
      email: 'chamodimadhushani18@gmail.com',
 main
      photoAsset: 'assets/images/member_05.jpg',
      designStyleName: 'Personal Journey Timeline',
      accentColor: Color(0xFF1B4D3E),
      bioQuote:
          'Passionate about exploring new technologies, applying academic knowledge to real-world projects, and growing as a Software Engineer.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'G.C.E. Ordinary Level Examination',
          institution: 'Sri Gnanodaya Central College, Divulapitiya',
          year: '2013 – 2019',
          gradeOrStatus: '4 As, 4 Bs, 1 C',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'G.C.E. Advanced Level Examination',
          institution: "President's College, Minuwangoda",
          year: '2020 – 2022',
          gradeOrStatus: '1 C, 2 Ss',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Certificate Course in Web Design for Beginners',
          institution: 'CODL, University of Moratuwa',
          year: 'Year (Placeholder)',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Certificate Course in Python for Beginners',
          institution: 'CODL, University of Moratuwa',
          year: 'Year (Placeholder)',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Certificate Course in Introduction to Data Science',
          institution: 'CISCO Networking Academy',
          year: 'Year (Placeholder)',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'Diploma in Information Technology & English',
          institution: 'Esoft Metro Campus',
          year: 'Year (Placeholder)',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Undergraduate',
          title: 'Undergraduate in Information Technology',
          institution: 'Institute of Technology, University of Moratuwa',
          year: '2025 – Present',
          gradeOrStatus: 'Ongoing',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Teamwork',
          level: 0.90,
          description:
              'Collaborates effectively on group software and IoT projects such as the Smart Medical Hand Band system.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0.88,
          description:
              'Strong interpersonal communication for presenting technical work and coordinating across team roles.',
        ),
        SoftSkill(
          name: 'Problem Solving',
          level: 0.92,
          description:
              'Applies analytical thinking to full-stack web, Firebase, and Flutter mobile application challenges.',
        ),
        SoftSkill(
          name: 'Time Management',
          level: 0.87,
          description:
              'Balances undergraduate studies, technical certifications, and hands-on development projects.',
        ),
        SoftSkill(
          name: 'Self-Learning',
          level: 0.94,
          description:
              'Quick learner passionate about exploring new technologies and continuously improving technical skills.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Dancing',
          category: 'Art',
          detail: 'Enjoys dancing as a creative and artistic expression.',
        ),
        SpecialTalent(
          title: 'Table Tennis',
          category: 'Sports',
          detail: 'Enjoys playing table tennis as a recreational sport.',
        ),
        SpecialTalent(
          title: 'Volleyball',
          category: 'Sports',
          detail: 'Enjoys playing volleyball as a team sport.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 06 — Thiruththanikan
    // Screen file: lib/screens/members/member_06_screen.dart
    // Design Style: Magazine-Style Profile
    // =========================================================================
    GroupMember(
      id: 'member_06',
      memberNumber: 6,


      studentId: '23IT0539',
      fullName: 'Thiruththanikan',
      shortRole: 'Software Engineer · Full-Stack & AI Solutions Developer',
      shortDescription:
          'Thiruththanikan is an Information Technology undergraduate and '
          'software engineer with experience in full-stack development, machine '
          'learning, and cloud deployment. As a digital assistant at Commercial '
          'Bank of Ceylon, he helped retail clients use online and mobile '
          'banking services and resolve transaction issues.',
      address: 'Point Pedro, Sri Lanka',
      email: 'thiruththanikan2003@gmail.com',
 main
      photoAsset: 'assets/images/member_06.jpg',
      designStyleName: 'Magazine Editorial',
      accentColor: Color(0xFF97502F),
      bioQuote:
          'Translating business and operational requirements into high-impact '
          'digital solutions',
      qualifications: [
        AcademicQualification(
          level: 'National Diploma',
          title:
              'National Diploma in Technology (NDT) in Information Technology',
          institution: 'Institute of Technology, University of Moratuwa',
          year: '2024 – Present',
          gradeOrStatus: 'In progress',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'Advanced Level · Physical Science',
          institution: 'J / Hartley College',
          year: '2022/2023',
          gradeOrStatus: 'Grades not provided (placeholder)',
        ),
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'Ordinary Level Examination',
          institution: 'J / Hartley College',
          year: '2019',
          gradeOrStatus: 'Grades not provided (placeholder)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Python for Beginners',
          institution:
              'Institute of Technology / University of Moratuwa (CODL)',
          year: 'Year not provided (placeholder)',
        ),
      ],
      softSkills: [
        // The model requires a level. This profile presents unscored labels.
        SoftSkill(
          name: 'Customer communication',
          level: 0,
          description:
              'Guided retail clients through digital banking workflows.',
        ),
        SoftSkill(
          name: 'Problem solving',
          level: 0,
          description: 'Troubleshot authentication and transaction queries.',
        ),
        SoftSkill(
          name: 'Explaining technical concepts',
          level: 0,
          description:
              'Broke complex workflows into steps customers could follow.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'ResQAI',
          category: 'Applied AI',
          detail:
              'Designed a disaster-response platform that processes voice, text, '
              'and image reports to help prioritize rescue dispatch.',
        ),
        SpecialTalent(
          title: 'Interactive portfolio',
          category: 'Frontend engineering',
          detail:
              'Built a responsive React portfolio to showcase projects and '
              'credentials, with accessible components and smooth transitions.',
        ),
        SpecialTalent(
          title: 'Enterprise event management',
          category: 'Full-stack development',
          detail:
              'Developed a platform for event discovery, registration, and '
              'ticketing, with role-based administration.',
        ),
        SpecialTalent(
          title: 'Not provided (placeholder)',
          category: 'Hobbies',
          detail: 'The biography supplied no hobby information.',
        ),
      ],
    ),

    // =========================================================================
    // MEMBER 07 — Thuvijavanthy Yogaraj
    // Screen file: lib/screens/members/member_07_screen.dart
    // Design Style: Dark Cyberpunk / Futuristic Dashboard
    // =========================================================================
    GroupMember(
      id: 'member_07',
      memberNumber: 7,


      studentId: 'STU-2026-007 (Placeholder)',
      fullName: 'Thuvijavanthy Yogaraj',
      shortRole: 'UI/UX Designer & IT Student',
      shortDescription:
          'Creative Information Technology student at ITUM with two UI/UX certifications, designing dashboards and user flows in Figma and building practical interfaces in HTML, CSS, and React.js.',
      address: 'City / District, Sri Lanka (Placeholder)',
      email: 'yogarajthuvi123@gmail.com',
 main
      photoAsset: 'assets/images/member_07.jpg',
      designStyleName: 'Dark Cyberpunk',
      accentColor: Color(0xFF00F5D4),
      bioQuote:
          'Designing intuitive, user-centred digital experiences that remain practical to develop.',
      qualifications: [
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'G.C.E. Advanced Level',
          institution: 'T/Sri Shanmuga Hindu Ladies College',
          year: '2022',
          gradeOrStatus: 'Results (Placeholder)',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'UI/UX for Designers',
          institution: 'Simplilearn',
          year: '2026',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Certificate',
          title: 'Introduction to Graphic Design & Basics of UI/UX',
          institution: 'Simplilearn',
          year: '2026',
          gradeOrStatus: 'Completed',
        ),
        AcademicQualification(
          level: 'Diploma',
          title: 'National Diploma in Technology (NDT) – Information Technology',
          institution: 'Institute of Technology, University of Moratuwa (ITUM)',
          year: '2025 – 2028 (Expected)',
          gradeOrStatus: 'Ongoing',
        ),
      ],
      softSkills: [
        SoftSkill(
          name: 'Creative Thinking',
          level: 0.90,
          description:
              'Creative thinking, visual communication, and attention to detail in UI/UX craft (level placeholder).',
        ),
        SoftSkill(
          name: 'Empathy & Problem-Solving',
          level: 0.88,
          description:
              'Empathy for users, problem-solving, and critical thinking across user flows (level placeholder).',
        ),
        SoftSkill(
          name: 'Communication & Teamwork',
          level: 0.86,
          description:
              'Verbal and written communication paired with collaborative team execution (level placeholder).',
        ),
        SoftSkill(
          name: 'Work Ethic & Adaptability',
          level: 0.89,
          description:
              'Time management, adaptability, and an eager quick-learner mindset (level placeholder).',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'UI/UX & Figma Prototyping',
          category: 'Design Talent',
          detail:
              'User research basics, user flows, wireframing, prototyping, and responsive dashboards in Figma.',
        ),
        SpecialTalent(
          title: 'Graphic & Visual Design',
          category: 'Creative Talent',
          detail:
              'Visual hierarchy, typography, colour theory, and graphic design fundamentals.',
        ),
        SpecialTalent(
          title: 'Front-End Interfaces',
          category: 'Technical Talent',
          detail:
              'Building practical user interfaces with HTML, CSS, JavaScript, React.js, Git, and GitHub.',
        ),
        SpecialTalent(
          title: 'Personal Hobby (Placeholder)',
          category: 'Hobby (Placeholder)',
          detail:
              'Placeholder — update with verified personal hobbies or extracurricular interests.',
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


      studentId: 'Not provided',
      fullName: 'Sahabdeen Fathima Shahfa',
      shortRole: 'IT undergraduate · AI/ML',
      shortDescription: 'IT undergraduate with university project experience in machine learning and natural language processing.',
      address: 'Not provided',
      email: 'fathimashahfa03@gmail.com',
 main
      photoAsset: 'assets/images/member_08.jpg',
      designStyleName: 'Modern Bento Grid',
      accentColor: Color(0xFF534386),
      bioQuote: 'Not provided',
      qualifications: [
        AcademicQualification(
          level: 'Diploma',
          title: 'National Diploma in Information Technology',
          institution: 'Institute of Technology, University of Moratuwa',
          year: '2025–Present',
          gradeOrStatus: 'In progress',
        ),
        AcademicQualification(
          level: 'G.C.E. A/L',
          title: 'G.C.E. Advanced Level · Physical Science',
          institution: 'Km/Mahmud Ladies College, Kalmunai',
          year: '2020–2022',
        ),
        AcademicQualification(
          level: 'G.C.E. O/L',
          title: 'G.C.E. Ordinary Level',
          institution: 'Km/Mahmud Ladies College, Kalmunai',
          year: '2019',
        ),
      ],
      softSkills: [
        // The CV lists these skills without proficiency scores.
        SoftSkill(
          name: 'Attention to Detail',
          level: 0,
          description:
              'Processed and cleaned data for a university AI project.',
        ),
        SoftSkill(
          name: 'Analytical Thinking',
          level: 0,
          description: 'Trained and evaluated machine learning models.',
        ),
        SoftSkill(
          name: 'Problem Solving',
          level: 0,
          description: 'Worked on complaint priority prediction and duplicate detection.',
        ),
        SoftSkill(
          name: 'Communication',
          level: 0,
          description: 'Listed as a soft skill in the CV.',
        ),
        SoftSkill(
          name: 'Teamwork',
          level: 0,
          description: 'Contributed to the AI module of a university project.',
        ),
      ],
      talents: [
        SpecialTalent(
          title: 'Applied Machine Learning',
          category: 'Technical skill',
          detail: 'Prepared data and trained and evaluated models for a municipal services project.',
        ),
        SpecialTalent(
          title: 'Full-stack Development',
          category: 'Technical skill',
          detail: 'Built REST APIs and a React interface for TraceTest.',
        ),
        SpecialTalent(
          title: 'Hobbies not provided',
          category: 'Hobby',
          detail: 'No hobbies were listed in the CV.',
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
      shortDescription: 'Transforms profile metrics and academic milestones into interactive dashboards.',
      address: 'Anuradhapura, North Central Province (Placeholder City)',
      email: 'member09.placeholder@university.edu.example',
      photoAsset: 'assets/images/member_09.jpg',
      designStyleName: 'Modern Dashboard',
      accentColor: Color(0xFF2563EB),
      bioQuote:
          'Good dashboards turn raw facts into actionable insight at a glance.',
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
