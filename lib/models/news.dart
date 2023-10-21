import 'package:news/models/articale.dart';

class News {
  final int totalResults;
  final String status;
 
  final List<Article> articles;

  News({
    required this.totalResults,
    required this.status,
    
    required this.articles,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    List<dynamic> articlesData = json["articles"];

    List<Article> myArticles =
        articlesData.map((e) => Article.fromJson(e)).toList();

    return News(
      totalResults: json["totalResults"] as int,
      status: json["status"] as String,
      
      articles: myArticles,
    );
  }
}
