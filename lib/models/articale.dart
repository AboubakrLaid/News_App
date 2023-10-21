class ArticleFields {
  static const List<String> values = [
    title,
    description,
    urlToImage,
    url,
    sourceName,
    publishedAt,
  ];
  static const String title = "title";
  static const String description = "description";
  static const String urlToImage = "urlToImage";
  static const String url = "url";
  static const String sourceName = "name";
  static const String publishedAt = "publishedAt";
}

class Article {
  final String? author, urlToImage, content, description;
  final String title, url, publishedAt;
  final Source source;

  Article({
    this.author,
    required this.title,
    this.description,
    this.content,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json["author"] != null ? json["author"] as String? : null,
      title: json["title"] as String,
      description: json["description"] as String?,
      content: json["content"] != null ? json["content"] as String? : null,
      url: json["url"] as String,
      urlToImage: json["urlToImage"] as String?,
      publishedAt: json["publishedAt"] as String,
      // in the db, i did only stored the name of the source so i'll json["name"] instead of json["source"]
      // json["name"] == null => this article is from db else is from api response
      source: json["source"] == null
          ? Source(json["name"])
          : Source.fromJson(json["source"]),
    );
  }
}

class Source {
  final String name;
  Source(this.name);

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(json["name"] as String);
  }
}
