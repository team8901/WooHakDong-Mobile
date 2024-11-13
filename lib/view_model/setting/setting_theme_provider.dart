import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/setting_theme_mode.dart';

final settingThemeProvider = StateNotifierProvider<SettingThemeNotifier, SettingThemeMode>((ref) {
  return SettingThemeNotifier();
});

class SettingThemeNotifier extends StateNotifier<SettingThemeMode> {
  SettingThemeNotifier() : super(SettingThemeMode.system) {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? SettingThemeMode.system.index;
    state = SettingThemeMode.values[themeIndex];
  }

  void setThemeMode(SettingThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('theme_mode', mode.index);
  }
}
