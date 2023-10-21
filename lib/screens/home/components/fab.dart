import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/home/home_vm.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/screens/pages/Save_Page/save_page_vm.dart';
import 'package:news/util/export.dart';

class MyFAB extends StatefulWidget {
  const MyFAB({super.key});

  @override
  State<MyFAB> createState() => _MyFABState();
}

class _MyFABState extends State<MyFAB> {
  @override
  Widget build(BuildContext context) {
    Widget icon = const Icon(LineIcons.trash);
    Widget text = Text(context.localization.translate("clear all"));
    return Consumer<HomePageViewModal>(
      builder: (context, stateHome, __) {
        return Consumer<SavePageViewModel>(
          builder: (context, stateSave, _) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              width: stateSave.isExtended ? 100.w : 50.w,
              child: stateSave.isExtended
                  ? FloatingActionButton.extended(
                      backgroundColor: context.theme.primaryColor,
                      onPressed: () => stateSave.clearAllClicked(context),
                      isExtended: true,
                      icon: appLanguage.isArabic ? text : icon,
                      label: appLanguage.isArabic ? icon : text,
                    )
                  : FloatingActionButton(
                      backgroundColor: context.theme.primaryColor,
                      onPressed: () => stateSave.clearAllClicked(context),
                      child: icon,
                    ),
            );
          },
        );
      },
    );
  }
}
