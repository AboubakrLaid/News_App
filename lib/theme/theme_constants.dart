import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: GoogleFonts.lora().fontFamily,
  scaffoldBackgroundColor: const Color(0xFF0f0f0f),
  primaryColor: const Color(0xff673AB7),
  secondaryHeaderColor: const Color(0xFFFF9800),

  //
  //
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Color(0xff0f0f0f),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xff673AB7),
    behavior: SnackBarBehavior.floating,
    insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    
  ),
 
  //
  //
  iconTheme: const IconThemeData(
    size: 26,
    color: Color.fromRGBO(255, 255, 255, 1.0),
  ),
  //
  //
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
     headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    headlineSmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    labelSmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
  ),
  //
  //

  //
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff673AB7),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      alignment: Alignment.center,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xff673AB7)),
      ),
    ),
  ),
    dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF0f0f0f),
  )
);

ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: GoogleFonts.lora().fontFamily,
  scaffoldBackgroundColor: const Color(0xfff0f0f0),
  primaryColor: const Color(0xFF2196F3),
  secondaryHeaderColor: const Color(0xffFFC107),

  //
  //
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    backgroundColor: Color(0xfff0f0f0),
  ),
   snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF2196F3),
    behavior: SnackBarBehavior.floating,
    insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    
  ),
  //
  //
  iconTheme: const IconThemeData(
    size: 26,
    color: Color.fromRGBO(0, 0, 0, 1.0),
  ),
  //
  //
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    headlineLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    headlineSmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    labelMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
    labelSmall: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(0, 0, 0, 1),
    ),
  ),
  //
  //
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2196F3),
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
      padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      alignment: Alignment.center,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFF2196F3)),
      ),
    ),
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xfff0f0f0),
  )
);
