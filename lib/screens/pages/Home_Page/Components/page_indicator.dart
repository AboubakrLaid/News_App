import 'package:flutter/material.dart';
import 'package:news/theme/theme_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.activeIndex, required this.imagesLength});
  final int activeIndex;
  final int imagesLength;

  @override
  Widget build(BuildContext context) {
    return   Align(
            alignment: Alignment.center,
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: imagesLength,
              duration: const Duration(milliseconds: 330),
              effect: SlideEffect(
                activeDotColor: context.theme.primaryColor,
                dotColor: context.theme.primaryColor.withOpacity(0.3),
                dotHeight: 7,
                dotWidth: 20,
                // spacing: 10,
                type: SlideType.slideUnder,
              ),
            ),
          );
  }
}