import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:news/util/export.dart';


class AppTheme extends ChangeNotifier {
  //
  //*  this is a singleton class that's mean we have only a single app theme state
  //
  static final _instance = AppTheme._();
  AppTheme._() {
    _getThemeMode();
  }
  factory AppTheme() => _instance;
  //

  ThemeMode _themeMode = ThemeMode.system;
  set initThemeMode(ThemeMode loadedThemeMode) => _themeMode = loadedThemeMode;
  ThemeMode get themeMode => _themeMode;

  
  bool _isDark =
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  bool get isDark => _isDark;

  //
  // check theme_constants file
  ThemeData get lightTheme => kLightTheme;
  ThemeData get darkTheme => kDarkTheme;
  //
  //

  //

//! for switch button
  //* switch  theme function
  //
  void toggleTheme(BuildContext context) async {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        _isDark = true;

      case ThemeMode.dark:
        _themeMode = ThemeMode.light;
        _isDark = false;

      case ThemeMode.system:
        // checking the background color of the scaffold
        //! this color will change according to the app theme colors
        if (Theme.of(context).scaffoldBackgroundColor ==
            const Color.fromARGB(255, 5, 7, 20)) {
          _themeMode = ThemeMode.light;
          _isDark = false;
        } else {
          _themeMode = ThemeMode.dark;
          _isDark = true;
        }
    }
    notifyListeners();
    await localDB.setTheme(_isDark);
  }

  //* get theme mode from shared preferences (if the user already did choose a theme)
  //
  Future<void> _getThemeMode() async {
    bool? isDarkk = await localDB.isDarkMode();

    if (isDarkk == true) {
      _themeMode = ThemeMode.dark;
      _isDark = true;
      notifyListeners();
    } else if (isDarkk == false) {
      _themeMode = ThemeMode.light;
      _isDark = false;
      notifyListeners();
    } else {
      // if isDarkk == null
      _isDark =
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark;
      notifyListeners();
    }
  }

  //
  // *use the theme of the device
  void useSystemTheme(BuildContext context) async {
    _themeMode = ThemeMode.system;
    _isDark = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
    notifyListeners();
    await localDB.setTheme(_isDark);
  }

  void useDarkLightTheme(BuildContext context, {required bool isDark}) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _isDark = isDark;

    notifyListeners();
    await localDB.setTheme(_isDark);
  }
  //
}