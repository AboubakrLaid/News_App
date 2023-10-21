class CountryName {
  final String arabicName, englishName;

  CountryName({required this.arabicName, required this.englishName});

  factory CountryName.fromJson(Map<String, dynamic> json){
    String englishName = json["name"]["common"];
    String arabicName = json["translations"]["ara"]["common"];
    return CountryName(arabicName: arabicName, englishName: englishName);
  }
}
