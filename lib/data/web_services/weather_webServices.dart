import 'package:dio/dio.dart';

import '../../constants/strings.dart';

class Weather_WebServices {
  late Dio dio;

  Weather_WebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<Map<String, dynamic>>? getCurrentWeatherData(
      double lat, double lon, String apiKey) async {
    try {
      Response response = await dio.get(
        "weather",
        queryParameters: {"lat": lat, "lon": lon, "appid": apiKey},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>>? getForcastdatafor5days(
      double lat, double lon, String apiKey) async {
    try {
      Response response = await dio.get(
        "forecast",
        queryParameters: {"lat": lat, "lon": lon, "appid": apiKey},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
