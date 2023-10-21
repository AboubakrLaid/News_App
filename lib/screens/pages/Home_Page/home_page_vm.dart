import 'package:flutter/material.dart';
import 'package:news/localization/app_localizations.dart';
import 'package:news/models/all_sources.dart';
import 'package:news/models/country_name.dart';
import 'package:news/screens/pages/Home_Page/Components/section_sources/section_sources.dart';
import 'package:news/services/countries_name_services.dart';
import 'package:news/util/export.dart';

import '../../../models/news.dart';
import '../../../services/news_services.dart';

class HomePageViewModal extends ChangeNotifier {
  late Future<News?> dataFuture;
  CountryName? selectedCountry;
  List<String> countryCodes = const [
    "SA",
    "GR",
    "AE",
    "AR",
    "AT",
    "AU",
    "BE",
    "BG",
    "BR",
    "CA",
    "CH",
    "CN",
    "CO",
    "CU",
    "CZ",
    "DE",
    "EG",
    "FR",
    "GB",
    "HK",
    "HU",
    "ID",
    "IE",
    "IN",
    "IT",
    "JP",
    "KR",
    "LT",
    "LV",
    "MA",
    "MX",
    "MY",
    "NG",
    "NL",
    "NO",
    "NZ",
    "PH",
    "PL",
    "PT",
    "RO",
    "RS",
    "RU",
    "SE",
    "SG",
    "SI",
    "SK",
    "TH",
    "TR",
    "TW",
    "UA",
    "US",
    "VE",
    "ZA",
  ];
  List<CountryName> countryNames = [];

  ScrollController scrollController = ScrollController();

  final NewsServices _ser = NewsServices();
  AllSources? topHealines;
  News? countriesNews;
  bool appeatToast = true;

  Future<AllSources?> getSources() async {
    topHealines ??= await (_ser.getSources());

    return topHealines;
  }

  //  Future<AllSources?> getNull()async{return await null;}
  Future<News?> getCountryNews(int index) async {
    // dataFuture = initData();
    countriesNews ??= await (_ser.getCountryNews(countryCodes[index]));
    if (countryNames.isEmpty) await getCountriesNames();
    return countriesNews;
  }

  Future<List<CountryName?>> getCountriesNames() async {
    final CountriesNameServices countryServices = CountriesNameServices();
    for (var countryCode in countryCodes) {
      countryNames.add(
          await (countryServices.getCountryName(countryCode)) as CountryName);
    }
    selectedCountry = countryNames[0];

    return countryNames;
  }

  void showSectionHeadLines(
      {required BuildContext context,
      required String sectionName,
      required AnimationController animationController}) {
    showModalBottomSheet(
      context: context,
      transitionAnimationController: animationController,
      // showDragHandle: true,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: SectionSources(sectionName),
      ),
    );
  }



  Future<News?> initData() async {
  Future.delayed(Duration.zero);
  countriesNews = null;
   return null;
  }


  void changeCountry(BuildContext context, TextEditingController controller) {
    List<CountryName> filtredList = countryNames;
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (context) {
        return Dialog(
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 60,vertical: 100),
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            height: kHeight * 0.5,
            child: Stack(
              children: [
                TextFormField(
                  controller: controller,
                  // autofocus: true,
                  textInputAction: TextInputAction.search,
                  style: context.theme.textTheme.labelSmall!
                      .copyWith(fontSize: 15.0),
                  cursorColor: context.theme.primaryColor,

                  cursorOpacityAnimates: true,
                  // maxLength: 309,

                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  onChanged: (value) {
                    if (value == "") {
                      filtredList = countryNames;
                    } else {
                      final String temp = value.toLowerCase().trim();
                      filtredList = countryNames.where((cy) {
                        return appLanguage.isArabic
                            ? cy.arabicName.trim().toLowerCase().contains(temp)
                            : cy.englishName
                                .trim()
                                .toLowerCase()
                                .contains(temp);
                      }).toList();
                    }
                    Provider.of<Refresh>(context, listen: false).refresh();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8.0),
                    hintText:
                        context.localization.translate("Search a country"),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Icon(LineIcons.search, size: 20),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 49),
                  child: Consumer<Refresh>(builder: (context, _, __) {
                    return filtredList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: filtredList.length,
                            itemBuilder: (context, i) {
                              String name = appLanguage.isArabic
                                  ? filtredList[i].arabicName
                                  : filtredList[i].englishName;
                              return InkWell(
                                onTap: () {
                                  int index =
                                      countryNames.indexOf(filtredList[i]);
                                  selectedCountry = countryNames[index];
                                  // it is important to init dataFuture with null
                                  // because the fututre builder will not rebuild
                                  //if we only change the content of dataFuture
                                  dataFuture = initData();
                                  // to trigger the future builder of country_news.dart
                                  Provider.of<Refresh>(context, listen: false)
                                      .refresh();
                                      context.pop();
                                dataFuture =  getCountryNews(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    name,
                                    style:
                                        context.theme.textTheme.headlineSmall,
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              context.localization
                                  .translate("Country does not exist"),
                              style: context.theme.textTheme.headlineSmall,
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
