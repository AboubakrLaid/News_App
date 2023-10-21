import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/home/home.dart';
import 'package:news/screens/home/home_vm.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/screens/pages/Search/components/search_vm.dart';
import 'package:news/util/export.dart';

import 'screens/pages/Save_Page/save_page_vm.dart';
import 'services/connectivity_services.dart';

void main() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
 FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//  await   getCountriesNames();
 

  await crudStorage.open();
  // init theme mode from app theme
  bool? temp = await localDB.isDarkMode();
  appTheme.initThemeMode = temp == null
      ? ThemeMode.system
      : (temp == true ? ThemeMode.dark : ThemeMode.light);

  // init app language
  String? temp1 = await localDB.getDefaultLocal();
  appLanguage.currentLocale =
      temp1 == null || temp1 == "en" ? const Locale("en") : const Locale("ar");
  appLanguage.isArabic = appLanguage.currentLocale.languageCode == "ar";
  // init the default screen
  bool isSeen = await localDB.hasSeenOnboarding() ?? false;
  if (isSeen) {
    defaultScreen = const Home();
  }
  //init internet connection services
  await ConnectivityService.initIsDeviceConnected();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
     FlutterNativeSplash.remove();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
    appTheme.addListener(() => setState(() {}));
    appLanguage.addListener(() => setState(() {}));
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Refresh()),
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ChangeNotifierProvider(create: (context) => SearchViewModel()),
          ChangeNotifierProvider(create: (context) => SavePageViewModel()),
          ChangeNotifierProvider(create: (context) => HomePageViewModal()),
        ],
        child: MaterialApp.router(
          color: context.theme.scaffoldBackgroundColor,
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          theme: appTheme.lightTheme,
          darkTheme: appTheme.darkTheme,
          themeMode: appTheme.themeMode,
          themeAnimationCurve: Curves.ease,

          supportedLocales: appLanguage.supportedLocales,

          locale: appLanguage.currentLocale,

          localizationsDelegates: const [
            // loads the translations from json files of lang folder
            AppLocalizations.delegate,
            // built-in localizations of basic text for material widgets
            GlobalMaterialLocalizations.delegate,
            // same thing but for cupertino widgets
            GlobalCupertinoLocalizations.delegate,
            // responsibale for text direction LTR/ RTL
            GlobalWidgetsLocalizations.delegate,
            // AppLocalozation.
          ],

          // returns a locale which will be used by the app
          localeResolutionCallback: (locale, supportedLocales) {
            // check if the current device locale is supported
            if (locale != null) {
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return locale;
                }
              }
            }
            // if the device local is not supported then
            // returns Locale("en") from supported locales
            return supportedLocales.first;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    appTheme.dispose();
    super.dispose();
  }
}
