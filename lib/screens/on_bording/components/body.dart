import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';

class OnBordingBody extends StatelessWidget {
  const OnBordingBody(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    const List<String> image = [
      "images/newspaper.jpg",
      "images/flags.jpg",
      "images/white_house.jpg",
    ];

    //
    //
    //
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: EdgeInsets.only(bottom: 24.0.h, left: 12.0.w, right: 12.0.w),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight,
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      context.theme.scaffoldBackgroundColor.withOpacity(0.05),
                      context.theme.scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    image[index],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only( top: 400.0.h),
              child: BodyText(index),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(this.index, {super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    List<List<String>> text = [
      ["Get the latest news from ", "Stay ", "From art to politics, "],
      ["reliable sources", "up to date ", "anything "],
      [".", "news from all around the world.", "in this app."]
    ];

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: context.localization.translate(text[0][index]),
            style: context.theme.textTheme.bodyLarge,
          ),
          TextSpan(
            text:  context.localization.translate(text[1][index]),
            style: context.theme.textTheme.bodyLarge!
                .copyWith(color: context.theme.primaryColor),
          ),
          TextSpan(
            text:  context.localization.translate(text[2][index]),
            style: context.theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
