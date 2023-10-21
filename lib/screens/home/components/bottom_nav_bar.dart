import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';

import '../home_vm.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    double gap = 8.0;
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 10.0,
    );

    return Consumer<HomeViewModel>(
      builder: (context, state, _) => GNav(
        selectedIndex: state.selectedIndex,
        onTabChange: (newIndex) => state.onTap(newIndex,context),
        backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.2),
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBackgroundColor: context.theme.primaryColor,
        tabMargin: const EdgeInsets.only(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
        ),
        tabBorderRadius: 20.0,

        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
        // activeColor: Colors.red,
        iconSize: 25,
        tabs: [
          GButton(
            padding: padding,
            gap: gap,
            icon: LineIcons.home,
            text:context.localization.translate( "Home"),
            textStyle: context.theme.textTheme.labelSmall,

          ),
          GButton(
            gap: gap,
            padding: padding,
            icon: LineIcons.search,
            text: context.localization.translate( "Explore"),
            textStyle: context.theme.textTheme.labelSmall,

          ),
          GButton(
            gap: gap,
            padding: padding,
            icon: LineIcons.bookmark,
            text: context.localization.translate( "Saved"),
            textStyle: context.theme.textTheme.labelSmall,

          ),
          // GButton(
          //   gap: gap,
          //   padding: padding,
          //   icon: LineIcons.cog,
          //   text: context.localization.translate( "Settings"),
          //   textStyle: context.theme.textTheme.labelSmall,
          // ),
        ],
      ),
    );
  }
}
