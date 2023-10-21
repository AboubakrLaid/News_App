// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';

class AppLanguage extends ChangeNotifier {
  static final AppLanguage _instance = AppLanguage._();

  AppLanguage._();

  factory AppLanguage() => _instance;

  Locale currentLocale = const Locale("en");
  List<Locale> supportedLocales = const [Locale("en"), Locale("ar")];
  VerticalDirection verticalDirection = VerticalDirection.up;
  bool isArabic = false;

  void setLocale(String x) async {
    currentLocale = Locale(x);
    isArabic = !isArabic;
    await localDB.setDefaultLocal(x);
    // for news app 
    Jiffy.setLocale(currentLocale.languageCode);
    Provider.of<HomePageViewModal>(listen: false, scaffoldMessengerKey.currentState!.context).topHealines = null;

    notifyListeners();
  }
}
