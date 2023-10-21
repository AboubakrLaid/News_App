import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';

class SectionImage extends StatefulWidget {
  const SectionImage(this.imageName, this.icon, {super.key});
  final String imageName;
  final IconData icon;

  @override
  State<SectionImage> createState() => _SectionImageState();
}

class _SectionImageState extends State<SectionImage>
    with SingleTickerProviderStateMixin {
  //
  //
  late AnimationController _animationController;
  //
  //
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 360),);
  }

  //
  //
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final state = Provider.of<HomePageViewModal>(listen: false, context);

        state.showSectionHeadLines(
          context: context,
          sectionName: widget.imageName,
          animationController: _animationController,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: kHeight * 0.35,
                width: kWidth,
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.theme.scaffoldBackgroundColor,
                        Colors.transparent
                      ],
                      begin: appLanguage.isArabic
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      end: Alignment.center,
                    ),
                  ),
                  child: Hero(
                    tag: widget.imageName,
                    child: Image.asset(
                      "images/${widget.imageName.toLowerCase()}.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -constraints.maxHeight * 0.05,
              left: appLanguage.isArabic ? null : 50,
              right: appLanguage.isArabic ? 50 : null,
              child: Container(
                // height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                decoration: BoxDecoration(
                    // color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        context.theme.scaffoldBackgroundColor,
                        context.theme.primaryColor
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                // height: 50,
                // width: 40,
                child: Row(
                  children: [
                    Icon(widget.icon),
                    const SizedBox(width: 10.0),
                    Text(
                      context.localization.translate(widget.imageName),
                      style: context.theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  //
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
