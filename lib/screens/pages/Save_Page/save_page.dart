import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/pages/Save_Page/save_page_vm.dart';
import 'package:news/util/export.dart';
import 'package:news/widgets/article_widget.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    //
    //
    Widget icon = const Icon(
      LineIcons.trash,
      size: 50,
    );

    final state = Provider.of<SavePageViewModel>(listen: false, context);
    //
    //
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) => state.onScroll(notification),
        child: Consumer<Refresh>(
          builder: (context,_,__) {
            return articles.isEmpty ?Center(
              child: Text(context.localization.translate("There are no articles saved yet."),style: context.theme.textTheme.labelSmall ,),
            ) : ListView.separated(
              controller: state.scrollController,
              itemCount: articles.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return Dismissible(
                  resizeDuration: const Duration(milliseconds: 500),
                  movementDuration: const Duration(milliseconds: 300),
                  behavior: HitTestBehavior.translucent,
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [icon, icon],
                    ),
                  ),
                  onDismissed: (direction) async {
                    final art = articles[index];
                    setState(() {
                      articles.removeAt(index);
                    });

                    await crudStorage.deleteArticle(art, context);
                  },
                  key: Key(articles[index].url),
                  child: ArticleWidget(articles[index]),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
