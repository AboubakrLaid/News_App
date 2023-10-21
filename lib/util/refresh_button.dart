import 'package:flutter/material.dart';
import 'package:news/util/export.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton(this.refresh, {super.key});
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      style: IconButton.styleFrom(
          side: BorderSide(color: context.theme.primaryColor)),
      color: context.theme.primaryColor,
      onPressed: () {
        refresh();
        Provider.of<Refresh>(context, listen: false).refresh();
      },
      icon: const Icon(
        LineIcons.syncIcon,
        size: 30,
      ),
    );
  }
}
