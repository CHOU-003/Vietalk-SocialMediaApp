import 'package:flutter/material.dart';
import 'package:social_media_app/util/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    primaryColor: primaryColorLight,
    scaffoldBackgroundColor: backgroundColorLight,
    textTheme: TextTheme(bodyLarge: TextStyle(color: textColorLight)),
    appBarTheme: AppBarTheme(color: primaryColorLight),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColorLight,
    ),
  );

  ThemeData get darkTheme => ThemeData(
    primaryColor: primaryColorBlack,
    scaffoldBackgroundColor: backgroundColorBlack,
    textTheme: TextTheme(bodyLarge: TextStyle(color: textColorBlack)),
    appBarTheme: AppBarTheme(color: primaryColorBlack),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColorBlack,
    ),
  );
}
