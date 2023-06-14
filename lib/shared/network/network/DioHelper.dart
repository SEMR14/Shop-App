import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static intial() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.post(url, data: data, queryParameters: query);
  }

  static Future<Response> GetData({
    required String url,
    Map<String, dynamic>? quary,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: quary);
  }

  static Future<Response> putdata({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio!.put(url, data: data, queryParameters: query);
  }
}
