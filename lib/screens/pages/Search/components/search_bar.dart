import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/pages/Search/search_page.dart';
import 'package:news/util/export.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar(
      {super.key,
      required this.textController,
      required this.state,
      required this.onFieldSubmitted});

  final TextEditingController textController;
  final Refresh state;
  final OnFieldSubmitted onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextFormField(
            controller: textController,
            // autofocus: true,
            textInputAction: TextInputAction.search,
            style: context.theme.textTheme.labelSmall!.copyWith(fontSize: 15.0),
            cursorColor: context.theme.primaryColor,

            cursorOpacityAnimates: true,
            // maxLength: 309,
            onChanged: (value) => state.refresh(),
            onFieldSubmitted: (value) => onFieldSubmitted(value),
            // onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              hintText: context.localization.translate("Search"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                child: Icon(LineIcons.search, size: 30),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: context.theme.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: context.theme.primaryColor, width: 2.4),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Consumer<Refresh>(
          builder: (context, x, _) {
            // if (textController.text.isNotEmpty) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: appLanguage.isArabic
                  ? EdgeInsets.only(
                      right: textController.text.isNotEmpty ? 16.0 : 0)
                  : EdgeInsets.only(
                      left: textController.text.isNotEmpty ? 16.0 : 0),
              width: textController.text.isEmpty ? 0 : null,
              // null means the child will take the amount of size he need
              child: AnimatedScale(
                scale: textController.text.isNotEmpty ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: InkWell(
                  child: const Icon(LineIcons.times, size: 24),
                  onTap: () {
                    textController.clear();
                    state.refresh();
                  },
                ),
              ),
            );
            // } else {
            // return const SizedBox(height: 0);
            // }
          },
        ),
      ],
    );
  }
}
