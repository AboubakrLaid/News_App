// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/models/articale.dart';
import 'package:news/util/export.dart';
import 'package:news/util/show_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCore extends StatelessWidget {
  final Article artical;
  const NewsCore(this.artical, {super.key});

  @override
  Widget build(BuildContext context) {
    //
    //
    bool articleAlreadySaved(Article art) {
      return articles
          .where((element) => element.urlToImage == art.urlToImage)
          .toList()
          .isNotEmpty;
    }

    //
    //
    void openInBrowser() async {
      final Uri url = Uri.parse(artical.url);
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(appLanguage.isArabic
              ? LineIcons.angleRight
              : LineIcons.angleLeft),
        ),
        
        actions: [
          Consumer<Refresh>(builder: (context, value, child) {
            return !articleAlreadySaved(artical)
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () async {
                      await crudStorage.insertArticle(
                        context,
                        title: artical.title,
                        description: artical.description,
                        url: artical.url,
                        urlToImage: artical.urlToImage,
                        sourceName: artical.source.name,
                        publishedAt: artical.publishedAt,
                      );
                      showSnackBar(context, "Saved succesfully");
                    },
                    child: const Icon(LineIcons.bookmark, size: 25),
                   
                  ),
                )
                : const Center();
          }),
        ],
        
      ),
      body: ListView(
        primary: true,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          Text(
            artical.title,
            style: context.theme.textTheme.bodyLarge!.copyWith(fontSize: 28),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                // constraints: ,
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    color: context.theme.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  artical.source.name,
                  style: context.theme.textTheme.headlineSmall!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          if (artical.urlToImage != null)
            Hero(
              tag: artical.title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: kHeight * 0.4,
                  width: kWidth,
                  child: Image.network(
                    artical.urlToImage!,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(LineIcons.bug),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 20.0),
          Text(
            artical.description ?? "",
            style:
                context.theme.textTheme.headlineSmall!.copyWith(fontSize: 23),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.localization.translate("read the whole article"),
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              const SizedBox(width: 8.0),
              IconButton.filled(
                onPressed: openInBrowser,
                icon: const Icon(LineIcons.alternateExternalLink, size: 30),
                tooltip: context.localization.translate("open in browser"),
                style: IconButton.styleFrom(
                  backgroundColor: context.theme.primaryColor,
                  foregroundColor: context.theme.scaffoldBackgroundColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
         
        ],
      ),
    );
  }
}
