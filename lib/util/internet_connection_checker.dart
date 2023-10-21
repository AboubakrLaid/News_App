import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/services/connectivity_services.dart';
import 'package:news/util/export.dart';

class InternetConnectionChecker extends StatelessWidget {
  const InternetConnectionChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: ConnectivityService.isDeviceConnected,
      stream: ConnectivityService.myStreamController.stream,
      builder: (context, snapshot) {
        return snapshot.data != null
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 370),
                height: !snapshot.data! ? 30.h : 0,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: context.theme.primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!ConnectivityService.isDeviceConnected)
                      const Icon(Icons.wifi_off_outlined),
                    const SizedBox(width: 16.0),
                    FittedBox(
                      child: Text(
                        context.localization
                            .translate("No internet connection"),
                        style: context.theme.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
              )
            : Container(height: 0);
      },
    );
  }
}
