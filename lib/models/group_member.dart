import 'package:flutter/material.dart';

/// Represents a single academic qualification entry for a group member.
class AcademicQualification {
  const AcademicQualification({
    required this.level,
    required this.title,
    required this.institution,
    required this.year,
    this.gradeOrStatus,
  });

  final String level;
  final String title;
  final String institution;
  final String year;
  final String? gradeOrStatus;
}

/// Represents a soft skill with an optional proficiency (0.0 to 1.0) and summary.
class SoftSkill {
  const SoftSkill({
    required this.name,
    required this.level,
    this.description = '',
  });

  final String name;
  final double level;
  final String description;
}

/// Represents a special talent or hobby item.
class SpecialTalent {
  const SpecialTalent({
    required this.title,
    required this.category,
    required this.detail,
  });

  final String title;
  final String category;
  final String detail;
}

/// Domain model representing one of the 9 group members.
///
/// Every bio screen renders all required CA 02 fields from this model:
/// fullName, address, email, qualifications, photoAsset, softSkills, and talents.
class GroupMember {
  const GroupMember({
    required this.id,
    required this.memberNumber,
    required this.studentId,
    required this.fullName,
    required this.shortRole,
    required this.shortDescription,
    required this.address,
    required this.email,
    required this.photoAsset,
    required this.designStyleName,
    required this.accentColor,
    required this.qualifications,
    required this.softSkills,
    required this.talents,
    required this.bioQuote,
  });

  final String id;
  final int memberNumber;
  final String studentId;
  final String fullName;
  final String shortRole;
  final String shortDescription;
  final String address;
  final String email;
  final String photoAsset;
  final String designStyleName;
  final Color accentColor;
  final List<AcademicQualification> qualifications;
  final List<SoftSkill> softSkills;
  final List<SpecialTalent> talents;
  final String bioQuote;

  /// Checks whether this member matches a directory search query.
  bool matchesQuery(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return true;

    return fullName.toLowerCase().contains(normalized) ||
        shortRole.toLowerCase().contains(normalized) ||
        shortDescription.toLowerCase().contains(normalized) ||
        address.toLowerCase().contains(normalized) ||
        designStyleName.toLowerCase().contains(normalized) ||
        studentId.toLowerCase().contains(normalized) ||
        softSkills.any((s) => s.name.toLowerCase().contains(normalized)) ||
        talents.any((t) =>
            t.title.toLowerCase().contains(normalized) ||
            t.category.toLowerCase().contains(normalized)) ||
        qualifications.any((q) => q.title.toLowerCase().contains(normalized));
  }
}
