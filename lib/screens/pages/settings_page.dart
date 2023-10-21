import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
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
              Switch(
                value: appTheme.isDark,
                onChanged: (value) => appTheme.toggleTheme(context),
                activeColor: context.theme.primaryColor,
                inactiveTrackColor: context.theme.scaffoldBackgroundColor,
                trackOutlineColor: MaterialStatePropertyAll(
                    const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.5)),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          Row(
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
              SegmentedButton(
                segments: [
                  ButtonSegment(
                      value: 1,
                      label: Text(context.localization.translate("English"))),
                  ButtonSegment(
                      value: 0,
                      label: Text(context.localization.translate("Arabic"))),
                ],
                onSelectionChanged: (newSelected) {
                  appLanguage.setLocale(newSelected.first == 0 ? "ar" : "en");
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
          InkWell(
            onTap: ()async=>await crudStorage.clearAll(context) ,
            child:  const Text("Remove all"),
          )
        ],
      ),
    );
  }
}
