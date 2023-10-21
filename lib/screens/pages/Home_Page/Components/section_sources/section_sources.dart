import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/models/source.dart';
import 'package:news/models/all_sources.dart';
import 'package:news/screens/pages/Home_Page/Components/section_sources/section_app_bar.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';
import 'package:news/util/refresh_button.dart';
import 'package:news/widgets/section_sources_widget.dart';

class SectionSources extends StatefulWidget {
  const SectionSources(this.imageName, {super.key});
  final String imageName;

  @override
  State<SectionSources> createState() => _SectionSourcesState();
}

class _SectionSourcesState extends State<SectionSources> {
  late Future<AllSources?> dataFuture;

  void getSources() {
    final state = Provider.of<HomePageViewModal>(context, listen: false);
    // state.topHealines = null;
    dataFuture = state.getSources();
  }

  @override
  void initState() {
    super.initState();
    getSources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SectionAppBar(widget.imageName),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => Consumer<Refresh>(
                builder: (context,_,__) {
                  return FutureBuilder(
                    future: dataFuture,
                    initialData: null,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Padding(
                            padding: const EdgeInsets.only(top: 150),
                            child: SizedBox.square(
                              dimension: 40,
                              child: FittedBox(
                                child: CircularProgressIndicator(
                                  color: context.theme.primaryColor,
                                  strokeWidth: 4.0,
                                ),
                              ),
                            ),
                          );
                        case ConnectionState.none:
                          return const Center();

                        case ConnectionState.done:
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                context.localization.translate(
                                    "Something went wrong, try again later"),
                                style: context.theme.textTheme.labelMedium,
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            //
                            final AllSources? data = snapshot.data;
                            //
                            if (data != null) {
                              //
                              //
                              final List<Source> articles = data.sources
                                  .where((e) =>
                                      e.category == widget.imageName.toLowerCase())
                                  .toList();
                              //
                              //
                              return articles.isNotEmpty
                                  ? ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: articles.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: SectionSourcesWidget(
                                            articles[index],
                                          ),
                                        );
                                      },
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 150),
                                      child: Text(
                                        context.localization
                                            .translate("Woow, Such an empty"),
                                        style: context.theme.textTheme.labelMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                            } else {
                              return Text(
                                context.localization.translate(
                                    "It seems like we are encountring some issues, try again later."),
                                style: context.theme.textTheme.labelSmall,
                              );
                            }
                          } else {
                            // null response
                            return Padding(
                              padding: const EdgeInsets.only(top: 150.0),
                              child: Center(child: RefreshButton(getSources)),
                            );
                          }
                      }
                    },
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
