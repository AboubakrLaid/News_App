import 'package:news/api/api.dart';
import 'package:news/models/news.dart';
import 'package:news/models/all_sources.dart';
import 'package:news/services/connectivity_services.dart';
import 'package:news/util/export.dart';

class NewsServices {
  // https://newsapi.org/v2/everything?q=keyword&apiKey=82d47cb1e40d444fac93ab343127f1d8
  static const String _apiKey = "82d47cb1e40d444fac93ab343127f1d8";

  static const String _baseUrl = "newsapi.org/v2";

  Future<News?> getEveryThingNews(
    String q, {
    String searchIn = "title,description,content",
    String sortBy = "publishedAt",
  }) async {
    if (ConnectivityService.isDeviceConnected) {
      Api api = Api();

      String url =
          "https://$_baseUrl/everything?q=$q&sortBy=$sortBy&searchIn=$searchIn&language=${appLanguage.currentLocale.languageCode}&apiKey=$_apiKey";

      final data = await api.sentRequest(url);

      if (data == null) {
        log.e("getting null response");
        return null;
      } else {
        log.d("get news success");
        return News.fromJson(data);
      }
    } else {
      log.d("no internet");
      return null;
    }
  }

  Future<AllSources?> getSources() async {
    if (ConnectivityService.isDeviceConnected) {
      Api api = Api();
      String url =
          "https://$_baseUrl/top-headlines/sources?language=${appLanguage.currentLocale.languageCode}&apiKey=$_apiKey";

      final data = await api.sentRequest(url);

      if (data == null) {
        log.e("getting null response");
        return null;
      } else {
        log.d("get sources success");
        return AllSources.fromJson(data);
      }
    } else {
      log.e("no internet");
    }
    return null;
  }

   Future<News?> getCountryNews(String countryCode) async {
    if (ConnectivityService.isDeviceConnected) {
      Api api = Api();
      String url =
          "https://$_baseUrl/top-headlines?country=$countryCode&apiKey=$_apiKey";

      final data = await api.sentRequest(url);

      if (data == null) {
        log.e("getting null response");
        return null;
      } else {
        log.d("get country news success");
        return News.fromJson(data);
      }
    } else {
      log.e("no internet");
    }
    return null;
  }
}
