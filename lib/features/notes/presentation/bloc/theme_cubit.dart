import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

// Cubit
class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences sharedPreferences;
  static const String THEME_KEY = 'theme_mode';

  ThemeCubit({required this.sharedPreferences}) 
      : super(ThemeState(themeMode: _loadThemeMode(sharedPreferences)));

  void toggleTheme() {
    final newThemeMode = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    _saveThemeMode(newThemeMode);
    emit(ThemeState(themeMode: newThemeMode));
  }

  void setTheme(ThemeMode themeMode) {
    _saveThemeMode(themeMode);
    emit(ThemeState(themeMode: themeMode));
  }

  void _saveThemeMode(ThemeMode themeMode) {
    sharedPreferences.setString(THEME_KEY, themeMode.toString());
  }

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final themeModeString = prefs.getString(THEME_KEY);
    if (themeModeString == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }
}
