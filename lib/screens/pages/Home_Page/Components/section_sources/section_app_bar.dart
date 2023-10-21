import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';


class SectionAppBar extends StatelessWidget {
  final String imageName;
 
  const SectionAppBar(this.imageName,{super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      leading: InkWell(
        onTap: () => context.pop(),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.primaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.only(
              bottomRight: !appLanguage.isArabic
                  ? const Radius.circular(30)
                  : Radius.zero,
              bottomLeft: appLanguage.isArabic
                  ? const Radius.circular(30)
                  : Radius.zero,
              topLeft: !appLanguage.isArabic
                  ? const Radius.circular(30)
                  : Radius.zero,
              topRight: appLanguage.isArabic
                  ? const Radius.circular(30)
                  : Radius.zero,
            ),
          ),
          child: Icon(
            appLanguage.isArabic ? LineIcons.angleRight : LineIcons.angleLeft,
          ),
        ),
      ),
      pinned: true,
      forceElevated: true,
      stretch: true,
    
      expandedHeight: 300,
      elevation: 10.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.fadeTitle,
          StretchMode.zoomBackground,
        ],
        
        centerTitle: true,
        title: FittedBox(
          child: Text(
            "${context.localization.translate(!appLanguage.isArabic ? imageName : "Sources")} ${context.localization.translate(!appLanguage.isArabic ? "Sources" : imageName)}",
            style: context.theme.textTheme.headlineMedium,
            maxLines: 1,
          ),
        ),
        
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                context.theme.scaffoldBackgroundColor,
                Colors.transparent
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            child: Hero(
              tag: imageName,
              child: Image.asset(
                "images/${imageName.toLowerCase()}.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
