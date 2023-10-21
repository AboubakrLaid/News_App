import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/screens/pages/Home_Page/Components/country_news/country_name.dart';
import 'package:news/screens/pages/Home_Page/Components/country_news/country_news.dart';
import 'package:news/screens/pages/Home_Page/Components/page_indicator.dart';
import 'package:news/screens/pages/Home_Page/Components/sections_image.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;
  late final CarouselController _carouselController;
  final List<String> _images = [
    "Buisness",
    "Entertainment",
    "General",
    "Health",
    "Science",
    "Sports",
    "Technology"
  ];
  final List<IconData> icons = [
    LineIcons.dollarSign,
    LineIcons.gamepad,
    LineIcons.newspaper,
    LineIcons.heartbeat,
    LineIcons.microscope,
    LineIcons.volleyballBall,
    LineIcons.microchip,
  ];

  // Future<void> getCountriesNames()async{
  //   final state = Provider.of<HomePageViewModal>(context,listen: false);
  // await state.loadCountriesNames(context);
  // }
  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    // if (!mounted) return;
    // getCountriesNames();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageViewModal>(context, listen: false);
    // getCountriesNames();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          Text(
            context.localization
                .translate("Explore all the sources for various topics"),
            style: context.theme.textTheme.headlineLarge!
                .copyWith(color: context.theme.primaryColor),
          ),
          const SizedBox(height: 30),
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _images.length,
            itemBuilder: (context, index, realIndex) => Align(
              alignment: Alignment.topCenter,
              child: SectionImage(_images[index], icons[index]),
            ),
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              height: kHeight * 0.37,
              viewportFraction: 0.75,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reason) {
                setState(() {
                  _activeIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          PageIndicator(
            activeIndex: _activeIndex,
            imagesLength: _images.length,
          ),
          const SizedBox(height: 80),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.localization.translate(
                      "Take a look at what is happening around the world"),
                  style: context.theme.textTheme.headlineLarge!
                      .copyWith(color: context.theme.primaryColor),
                  maxLines: 3,
                ),
              ),
              const SizedBox(width: 8.0),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    
                    child: Padding(
                    padding: const EdgeInsets.all(20),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${context.localization.translate("Note:")} ",
                              style: context.theme.textTheme.headlineSmall!
                                  .copyWith(color: Colors.red),
                            ),
                            TextSpan(
                              text: context.localization.translate(
                                  "The official language of the country will be the language used for all articles."),
                              style: context.theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                child: const Icon(LineIcons.info),
              )
            ],
          ),

          const SizedBox(height: 32),
          // InkWell(onTap: () => state.loadCountriesNames(context),child: const Text("gg")),

          const CountryNews(),
        ],
      ),
    );
  }
}


// Consumer<HomePageViewModal>(
//       builder: (context, state, child) => FutureBuilder(
//         future: dataFuture,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return const Center(child: CircularProgressIndicator());

//             case ConnectionState.done:
//             default:
//               if (snapshot.hasError) {
//                 return const Center(child: Text("something went wrong"));
//               } else if (snapshot.hasData) {
//                 return ListView.builder(
//                   itemCount: snapshot.data!.sources.where((e) => e.category == "entertainment").length,
//                   itemBuilder: (context, index) {
//                     List<TopArticle> x = snapshot.data!.sources.where((e) => e.category == "entertainment").toList();
//                     return Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: Column(
//                         children: [
//                           Text(x[index].name),
//                           Text(x[index].category),
//                           Text(x[index].description),
//                           Text(x[index].country),
//                           Text(x[index].language),
//                           Text(x[index].url),
//                         ],
//                       ),
//                     );
//                   },);
//               } else {
               // null response
//                 return const Center(child: Text("no data"));
//               }
//           }
//         },
//       ),
//     );
