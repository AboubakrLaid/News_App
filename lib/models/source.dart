class Source {
  final String name, description, url, category, language, country;

  Source({
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json["name"] as String,
      description: json["description"] as String,
      url: json["url"] as String,
      category: json["category"] as String,
      language: json["language"] as String,
      country: json["country"] as String,
    );
  }
}