import 'package:flutter/material.dart';

class AppLanguage extends ChangeNotifier {
  static final AppLanguage _instance = AppLanguage._();

  AppLanguage._();

  factory AppLanguage() => _instance;

  Locale currentLocale = const Locale("en");
  List<Locale> supportedLocales =const [Locale("en"), Locale("ar")];
  VerticalDirection verticalDirection = VerticalDirection.up;
  bool isArabic = false;



  void switchLocale() {
   switch (currentLocale.languageCode) {
     case 'en':
     currentLocale = const Locale('ar');
     verticalDirection = VerticalDirection.up;
     isArabic =!isArabic;
     default:
     currentLocale = const Locale('en');
     verticalDirection = VerticalDirection.down;
     isArabic =!isArabic;

   }
    notifyListeners();
  }
}