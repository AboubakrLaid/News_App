import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news/models/news.dart';
import 'package:news/services/news_services.dart';

class SearchViewModel extends ChangeNotifier {
  final NewsServices _ser = NewsServices();

  Future<News?> exploreNews(String q) async => await _ser.getEveryThingNews(q);

  bool? onScroll(UserScrollNotification not) {
    if (not.direction == ScrollDirection.forward) {
      return true;
    } else if (not.direction == ScrollDirection.reverse) {
      return false;
    }
    // it is idle or the state is monotony
    return null;
  }
}
