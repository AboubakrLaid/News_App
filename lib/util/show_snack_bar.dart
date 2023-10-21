import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.horizontal,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localization.translate(text),
            style: context.theme.textTheme.labelSmall,
          ),
          InkWell(
            onTap: () => ScaffoldMessenger.of(context).clearSnackBars(),
            child: const Icon(
              LineIcons.times,
              size: 24,
            ),
          )
        ],
      ),
    ),
  );
}
