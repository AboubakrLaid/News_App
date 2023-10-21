import 'package:flutter/material.dart';
import 'package:news/screens/home/components/bottom_nav_bar.dart';
import 'package:news/screens/home/components/fab.dart';
import 'package:news/screens/home/home_vm.dart';
import 'package:news/screens/pages/Home_Page/home_page.dart';
import 'package:news/screens/pages/Home_Page/home_page_vm.dart';
import 'package:news/screens/pages/Save_Page/save_page.dart';
import 'package:news/screens/pages/Search/search_page.dart';
import 'package:news/util/export.dart';
import 'package:news/util/internet_connection_checker.dart';

import 'components/drawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //
    //
    final List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const SavePage(),
      // const SettingsPage(),
    ];
    //

    //
    //
    return Consumer<HomeViewModel>(
      builder: (context, state, _) {
        return Scaffold(
          // extendBodyBehindAppBar:  true,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            leading: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(LineIcons.bars, size: 30),
                );
              },
            ),
          ),
          
          body: pages[state.selectedIndex],
          persistentFooterButtons:  const [
            //  Divider(color: context.theme.primaryColor,thickness: 2.0)
          ],
          drawerEdgeDragWidth: kWidth * .6,
          drawer: const MyDrawer(),
          drawerEnableOpenDragGesture: false,
          bottomNavigationBar: const BottomNavBar(),
          bottomSheet: const InternetConnectionChecker(),
          floatingActionButton:
              (state.selectedIndex == 2 && articles.isNotEmpty)
                  ? const MyFAB()
                  : null,
        );
      },
    );
  }
}
