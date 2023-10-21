import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news/util/export.dart';

import '../models/articale.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  const ArticleWidget(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> context.pushNamed("NewsCore",extra: article),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        padding: const EdgeInsets.all(8.0),
        
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            textDirection:
                appLanguage.isArabic ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Flexible(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                      style: context.theme.textTheme.headlineLarge!.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4.0),
                    Text(Jiffy.parse(article.publishedAt).MMMEd),
    
                    // const Spacer(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment:  CrossAxisAlignment.end,
                children: [
                  if (article.urlToImage != null)
                    Hero(
                      tag: article.title,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: 110.0,
                          width: 150.0,
                          child: Image.network(
                            article.urlToImage!,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(LineIcons.bug),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                // Image has finished loading
                                return child;
                              } else {
                                // Image is still loading, display a CircularProgressIndicator
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: context.theme.primaryColor,
                                    strokeWidth: 3.5,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12.0),
              SizedBox(
              width: 150,
                    child: Center(
                      child: Text(
                        article.source.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        
                        style: TextStyle(color: context.theme.primaryColor),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
