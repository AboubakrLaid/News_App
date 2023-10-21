// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/on_bording/components/body.dart';
import 'package:news/screens/on_bording/components/language_button.dart';
import 'package:news/screens/on_bording/components/theme_button.dart';
import 'package:news/screens/on_bording/components/progress_indicator.dart';
import 'package:news/util/export.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  double _value = 1 / 3;
  String buttonText = "next";

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.animateTo(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50.0.w,
        // leading: const Padding(
        //   padding: EdgeInsets.only(left: 8.0),
        //   child: Text("my logo"),
        // ),
        centerTitle: true,
        title: const LanguageButton(),
        actions: const [
          ThemeButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 8.0.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) => OnBordingBody(index),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return MyProgressIndicator(_animationController.value);
              },
            ),
            Positioned(
              bottom: 0,
              child: ElevatedButton(
                onPressed: () async{
                  if (_value == 1.0) {
                    await localDB.markOnBordingAsSeen();
                    context.pushReplacementNamed("Home");
                  } else {
                    _value += 1 / 3;
                    if (_value == 1.0) {
                      buttonText = "let's get started";
                    }

                    _animationController.animateTo(_value);
                    _pageController.animateToPage(
                      (3 * _value).toInt() - 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linearToEaseOut,
                    );
                    Provider.of<Refresh>(context, listen: false).refresh();
                  }
                },
                child: Consumer<Refresh>(
                  builder: (context, state, child) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      context.localization.translate(buttonText),
                      style: context.theme.textTheme.labelSmall,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
