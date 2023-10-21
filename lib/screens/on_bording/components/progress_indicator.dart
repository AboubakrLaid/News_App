import 'package:flutter/material.dart';
import 'package:news/util/export.dart';

class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator(this.value,{super.key});
  final double value;

  @override
  Widget build(BuildContext context) {
    return Positioned(
              bottom: 70.0.h,
              child: SizedBox(
                width: kWidth * .4,
                child: LinearProgressIndicator(
                  value:value,
                  backgroundColor: context.theme.primaryColor.withOpacity(0.3),
                  color: context.theme.primaryColor,
                ),
              ),
            );
  }
}