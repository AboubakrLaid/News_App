import 'package:flutter/material.dart';
import 'package:news/db/saved_articles_db.dart';
import 'package:news/models/articale.dart';
import 'package:news/models/country_name.dart';
import 'package:news/services/countries_name_services.dart';
import 'package:news/util/export.dart';


import '../theme/theme.dart';
import 'package:logger/logger.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final LocalDB localDB = LocalDB();
final AppTheme appTheme = AppTheme();
final AppLanguage appLanguage = AppLanguage();
final Logger log = Logger();

final kWidth =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.width;
final kHeight =
    MediaQuery.of(scaffoldMessengerKey.currentState!.context).size.height;

 List<Article> articles =[];   
 SavedArticlesDB crudStorage = SavedArticlesDB(dbName: "savedarticles1.db", dbVersion: 2) ;



