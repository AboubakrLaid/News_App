import 'package:flutter/material.dart';
import 'package:news/models/source.dart';
import 'package:news/theme/theme_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionSourcesWidget extends StatelessWidget {
  const SectionSourcesWidget(this.article, {super.key});
  final Source article;

  @override
  Widget build(BuildContext context) {
    //
    //
    void openInBrowser() async {
      final Uri url = Uri.parse(article.url);
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }

    //
    //
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      color: context.theme.primaryColor.withOpacity(0.2),
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.name,
              style: context.theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              article.description,
              style: context.theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: openInBrowser,
              child: Text(
                article.url,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  fontSize: 15,
                  color: Colors.blue.shade700,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
