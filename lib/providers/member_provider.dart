import 'package:flutter/material.dart';
import 'package:group_profile_app/constants/app_constants.dart';
import 'package:group_profile_app/data/members_data.dart';
import 'package:group_profile_app/models/group_member.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the 9 group members directory, live search, favourites,
/// endorsements, layout view mode, and app-level theme preference.
class MemberProvider extends ChangeNotifier {
  MemberProvider({List<GroupMember>? initialMembers})
      : _allMembers = initialMembers ?? MembersData.members {
    _loadPreferences();
  }

  final List<GroupMember> _allMembers;
  String _searchQuery = '';
  bool _onlyFavorites = false;
  bool _isGridView = true;
  bool _isDarkMode = false;
  final Set<String> _favoriteIds = <String>{};
  final Map<String, int> _endorsements = <String, int>{};

  List<GroupMember> get allMembers => _allMembers;
  String get searchQuery => _searchQuery;
  bool get onlyFavorites => _onlyFavorites;
  bool get isGridView => _isGridView;
  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  int get favoriteCount => _favoriteIds.length;

  List<GroupMember> get filteredMembers {
    return _allMembers.where((member) {
      if (_onlyFavorites && !_favoriteIds.contains(member.id)) {
        return false;
      }
      return member.matchesQuery(_searchQuery);
    }).toList();
  }

  bool isFavorite(String memberId) => _favoriteIds.contains(memberId);

  int endorsementCount(String memberId) => _endorsements[memberId] ?? 0;

  GroupMember? findById(String id) {
    for (final member in _allMembers) {
      if (member.id == id) return member;
    }
    return null;
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void clearSearch() {
    if (_searchQuery.isEmpty) return;
    _searchQuery = '';
    notifyListeners();
  }

  void toggleOnlyFavorites() {
    _onlyFavorites = !_onlyFavorites;
    notifyListeners();
  }

  Future<void> toggleViewMode() async {
    _isGridView = !_isGridView;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.prefGridView, _isGridView);
    } catch (_) {}
  }

  Future<void> toggleThemeMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.prefDarkMode, _isDarkMode);
    } catch (_) {}
  }

  Future<void> toggleFavorite(String memberId) async {
    if (_favoriteIds.contains(memberId)) {
      _favoriteIds.remove(memberId);
    } else {
      _favoriteIds.add(memberId);
    }
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        AppConstants.prefFavorites,
        _favoriteIds.toList(),
      );
    } catch (_) {}
  }

  void addEndorsement(String memberId) {
    _endorsements[memberId] = (_endorsements[memberId] ?? 0) + 1;
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDark = prefs.getBool(AppConstants.prefDarkMode);
      final savedGrid = prefs.getBool(AppConstants.prefGridView);
      final savedFavorites = prefs.getStringList(AppConstants.prefFavorites);

      if (savedDark != null) _isDarkMode = savedDark;
      if (savedGrid != null) _isGridView = savedGrid;
      if (savedFavorites != null) {
        _favoriteIds
          ..clear()
          ..addAll(savedFavorites);
      }
      notifyListeners();
    } catch (_) {
      // Safe fallback in test or restricted environments.
    }
  }
}
