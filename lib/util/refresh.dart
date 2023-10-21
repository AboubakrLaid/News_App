import 'package:flutter/material.dart';

class Refresh extends ChangeNotifier {
  void refresh()=> notifyListeners();
}