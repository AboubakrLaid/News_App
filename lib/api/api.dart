import 'package:dio/dio.dart';
import 'package:news/util/export.dart';

class Api {
  Api._();

  static final _instance = Api._();

  factory Api() => _instance;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> sentRequest(String url) async {
    try {
      Response<Map<String, dynamic>> response = await _dio.get(url);
   
      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return response.data;
      }
      return null;
    } catch (e) {
      log.e("error from request $e");
      return null;
    }
  }
}
