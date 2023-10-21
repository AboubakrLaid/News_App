import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/models/news.dart';
import 'package:news/screens/pages/Search/components/search_vm.dart';
import 'package:news/util/refresh_button.dart';
import 'package:news/widgets/article_widget.dart';

import '../../../util/export.dart';
import 'components/search_bar.dart';

typedef OnFieldSubmitted = void Function(String q);

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<News?>? searchFuture;
  bool isSearchBarVisibale = true;

  late TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  void getSearches() {
    final stateSearch = Provider.of<SearchViewModel>(context, listen: false);
    searchFuture = stateSearch.exploreNews(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    final stateSearch = Provider.of<SearchViewModel>(context, listen: false);
    final state = Provider.of<Refresh>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isSearchBarVisibale ? 1 : 0,
              child: MySearchBar(
                textController: _textController,
                state: state,
                onFieldSubmitted: (q) {
                  getSearches();
                  state.refresh();
                },
              ),
            ),
          ),
          //
          //
          //
          const SizedBox(height: 8.0),
          Consumer<Refresh>(
            builder: (context, state, child) => FutureBuilder(
              future: searchFuture,
              initialData: null,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Padding(
                      padding: EdgeInsets.only(top: kHeight * 0.3),
                      child: SizedBox.square(
                        dimension: 40.0,
                        child: CircularProgressIndicator(
                          color: context.theme.primaryColor,
                          strokeWidth: 4.0,
                        ),
                      ),
                    );

                  case ConnectionState.none:
                    return const Center();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Text(
                          context.localization.translate(
                              "Something went wrong, try again later"),
                          style: context.theme.textTheme.labelMedium,
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      //! snapshot has data
                      final News? data = snapshot.data;

                      if (data!.totalResults != 0) {
                        return Expanded(
                          child: NotificationListener<UserScrollNotification>(
                            onNotification: (notification) {
                              // if the return is null it means that there is no scroll
                              // thus the state stay as it is
                              // and only appear on scrolling up
                              bool temp = stateSearch.onScroll(notification) ??
                                  isSearchBarVisibale;
                              if (temp != isSearchBarVisibale) {
                                setState(() {
                                  isSearchBarVisibale = temp;
                                });
                              }

                              return false;
                            },
                            child: ListView.separated(
                              itemCount: snapshot.data!.articles.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                return ArticleWidget(data.articles[index]);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: Text(
                            context.localization.translate(
                                "Sorry, we couldn't find any news relative to this search"),
                            style: context.theme.textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: kHeight * 0.3),
                        child: RefreshButton(getSearches),
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
