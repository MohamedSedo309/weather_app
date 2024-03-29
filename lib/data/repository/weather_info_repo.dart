import 'package:weather_app/data/models/weather_forecast.dart';
import 'package:weather_app/data/web_services/weather_webServices.dart';

import '../models/weather_info.dart';

class WeatherInfo_Repo {
  final Weather_WebServices weather_webServices;

  WeatherInfo_Repo(this.weather_webServices);

  Future<Weather_Info> getWeatherInfo(
      double lat, double lon, String apiKey) async {
    final weather =
        await weather_webServices.getCurrentWeatherData(lat, lon, apiKey);
    return Weather_Info.fromjson(weather!);
  }

  Future<Weather_Forecast> getForecastInfo(
      double lat, double lon, String apiKey) async {
    final forecast =
        await weather_webServices.getForcastdatafor5days(lat, lon, apiKey);
    return Weather_Forecast.fromjson(forecast!);
  }
}
