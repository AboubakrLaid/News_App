import 'package:flutter/material.dart';
import 'package:news/util/export.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              alignment: Alignment.center,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              insetPadding: EdgeInsets.zero,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      appLanguage.setLocale("ar");
                      context.pop();
                      Provider.of<Refresh>(context, listen: false).refresh();
                    },
                    child: Text(
                      "العربية",
                      style: context.theme.textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      appLanguage.setLocale("en");
                      context.pop();
                      Provider.of<Refresh>(context, listen: false).refresh();
                    },
                    child: Text(
                      "English",
                      style: context.theme.textTheme.labelMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
      child: Consumer<Refresh>(
        builder: (context, value, child) => Text(
          appLanguage.isArabic ? "العربية" : "English",
          style: context.theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
