import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/home/home_vm.dart';
import 'package:news/theme/theme_constants.dart';
import 'package:news/util/export.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    //
    //
    final state = Provider.of<HomeViewModel>(listen: false, context);
    //
    //
    return Drawer(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      
      elevation: 10,
      width: kWidth,
      surfaceTintColor: context.theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: Align(
                      alignment: appLanguage.isArabic
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: const Icon(LineIcons.times, size: 35, color: Colors.grey,),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LineIcons.adjust, size: 30),
                        const SizedBox(width: 16.0),
                        Text(
                          context.localization.translate("Dark mode"),
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    Switch(
                      value: appTheme.isDark,
                      onChanged: (value) {
                        appTheme.toggleTheme(context);
                        Provider.of<Refresh>(listen: false, context).refresh();
                      },
                      activeColor: context.theme.primaryColor,
                      inactiveTrackColor: context.theme.scaffoldBackgroundColor,
                      trackOutlineColor: MaterialStatePropertyAll(
                          const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(LineIcons.language, size: 30),
                        const SizedBox(width: 16.0),
                        Text(
                          context.localization.translate("Language"),
                          style: context.theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    SegmentedButton(
                      segments: [
                        ButtonSegment(
                            value: 1,
                            label:
                                FittedBox(child: Text(context.localization.translate("English")))),
                        ButtonSegment(
                            value: 0,
                            label:
                                FittedBox(child: Text(context.localization.translate("Arabic")))),
                      ],
                      onSelectionChanged: (newSelected) {
                        appLanguage
                            .setLocale(newSelected.first == 0 ? "ar" : "en");
                      },
                      selected: appLanguage.isArabic ? {0} : {1},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.selected)
                              ? context.theme.primaryColor
                              : const Color.fromRGBO(0, 0, 0, 0);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // children: [
    //   InkWell(
    //     onTap:()=>state.openSettings(context, animationController) ,
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         const Icon(
    //           LineIcons.cog,
    //           size: 30,
    //           color: Colors.grey,
    //         ),
    //         const SizedBox(width: 10.0),
    //         Text(
    //           context.localization.translate("Settings"),
    //           style: context.theme.textTheme.labelMedium,
    //         )
    //       ],
    //     ),
    //   )
    // ],
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
