import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/models/articale.dart';
import 'package:news/models/news.dart';
import 'package:news/screens/pages/Home_Page/Components/country_news/country_name.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';
import 'package:news/util/refresh_button.dart';
import 'package:news/widgets/article_widget.dart';

class CountryNews extends StatefulWidget {
  const CountryNews({super.key});

  @override
  State<CountryNews> createState() => _CountryNewsState();
}

class _CountryNewsState extends State<CountryNews> {
  //
  //

  //
  //

  void getCountryNews() {
    final state = Provider.of<HomePageViewModal>(listen: false, context);

    state.dataFuture = state.getCountryNews(0);
  }

  @override
  void initState() {
    super.initState();
    getCountryNews();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageViewModal>(listen: false, context);

    return Consumer<Refresh>(
      builder: (context, _, child) => FutureBuilder(
        future: state.dataFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: SizedBox.square(
                    dimension: 40.0,
                    child: CircularProgressIndicator(
                      color: context.theme.primaryColor,
                      strokeWidth: 4.0,
                    ),
                  ),
                ),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    context.localization
                        .translate("Something went wrong, try again later"),
                        style: context.theme.textTheme.headlineSmall,
                  ),
                );
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CountryNameWidget(),
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.articles.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final List<Article> x = snapshot.data!.articles;
                        return ArticleWidget(x[index]);
                      },
                    )
                  ],
                );
              } else {
                //    null response
                return Center(child: RefreshButton(getCountryNews));
              }
          }
        },
      ),
    );
  }
}
