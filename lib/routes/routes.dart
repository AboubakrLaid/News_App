import 'package:flutter/material.dart';
import 'package:news/models/articale.dart';
import 'package:news/screens/home/home.dart';
import 'package:news/screens/on_bording/on_bording.dart';
import 'package:news/util/export.dart';

import '../widgets/News_Core/news_core.dart';

Widget defaultScreen = const OnBording();

final router = GoRouter(
  initialLocation: "/",
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: "/",
      name: "OnBording",
      builder: (context, state) => defaultScreen,
    ),
    GoRoute(
      path: "/Home",
      name: "Home",
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const Home(),
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: "/NewsCore",
      name: "NewsCore",
      pageBuilder: (context, state) {
        final Article art = state.extra as Article;
        return CustomTransitionPage(
          child: NewsCore(art),
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    ),
  ],
);
