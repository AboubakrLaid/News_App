// {

//     "status": "ok",
//     -
//     "sources": [
//         -
//         {
//             "id": "argaam",
//             "name": "Argaam",
//             "description": "ارقام موقع متخصص في متابعة سوق الأسهم السعودي تداول - تاسي - مع تغطيه معمقة لشركات واسعار ومنتجات البتروكيماويات , تقارير مالية الاكتتابات الجديده ",
//             "url": "http://www.argaam.com",
//             "category": "business",
//             "language": "ar",
//             "country": "sa"
//         },


import 'package:news/models/source.dart';

class AllSources {
  final List<Source> sources;

  AllSources(this.sources);

  factory AllSources.fromJson(Map<String, dynamic> json) {
   List<dynamic> temp = json["sources"];

   final List<Source> sources = temp.map((e) => Source.fromJson(e)).toList();

    return AllSources(sources);
  }
}
