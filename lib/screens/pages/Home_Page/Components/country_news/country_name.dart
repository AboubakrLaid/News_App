import 'package:flutter/material.dart';
import 'package:news/models/country_name.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/util/export.dart';

class CountryNameWidget extends StatefulWidget {
  const CountryNameWidget({super.key});

  @override
  State<CountryNameWidget> createState() => _CountryNameWidgetState();
}

class _CountryNameWidgetState extends State<CountryNameWidget> {
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<HomePageViewModal>(listen: false, context);
      String name = state.selectedCountry != null
                  ? (appLanguage.isArabic
                      ? state.selectedCountry!.arabicName
                      : state.selectedCountry!.englishName)
                  : "";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.primaryColor.withOpacity(0.2),
      ),
      child: InkWell(
        onTap: () => state.changeCountry(context, controller),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
               Text(
                name,
                style: context.theme.textTheme.headlineMedium,
              ),
            
            const Icon(
              LineIcons.flag,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
