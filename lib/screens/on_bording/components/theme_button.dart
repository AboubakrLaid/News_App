import 'package:flutter/material.dart';
import 'package:news/util/export.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    IconButton(
      onPressed: () {
        if (appTheme.isDark) {
          appTheme.useDarkLightTheme(context, isDark: false);
        } else {
          appTheme.useDarkLightTheme(context, isDark: true);
        }
        Provider.of<Refresh>(context, listen: false).refresh();
      },
      icon: Consumer<Refresh>(
        builder: (context, value, child) =>
         Icon(
          appTheme.isDark ? LineIcons.sunAlt : LineIcons.moon,
          size: 35,
        ),
      ),
    );
  }
}
