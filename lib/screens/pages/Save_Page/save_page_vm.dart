import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/util/export.dart';
import 'package:path/path.dart';

class SavePageViewModel extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  bool isExtended = true;

  bool onScroll(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.idle) {
      isExtended = true;
    } else {
      isExtended = false;
    }
    notifyListeners();
    return true;
  }

  void showCircularProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SizedBox.square(
        dimension: 200,
        child: Center(
          child: CircularProgressIndicator(color: context.theme.primaryColor),
        ),
      ),
    );
  }

  void clearAllClicked(BuildContext context) {
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          // title: Text(
          //   context.localization.translate("Warning"),
          // ),
          content: Text(
            context.localization.translate(
                "Are you certain that you want to delete all of your saved articles?"),
            style: context.theme.textTheme.labelMedium,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding:
              EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.0.h),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: Text(
                context.localization.translate("cancel"),
                style: context.theme.textTheme.headlineSmall!
                    .copyWith(color: context.theme.primaryColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                context.pop();
                await crudStorage.clearAll(context);
              },
              style: TextButton.styleFrom(
                  backgroundColor: context.theme.primaryColor),
              child: Text(
                context.localization.translate("clear"),
                style: context.theme.textTheme.headlineSmall!
                    .copyWith(color: context.theme.scaffoldBackgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
