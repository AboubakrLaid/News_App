import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {

  int selectedIndex = 0;

  void onTap(int newIndex, BuildContext context) {
    selectedIndex = newIndex;
    notifyListeners();
  }

  
}
