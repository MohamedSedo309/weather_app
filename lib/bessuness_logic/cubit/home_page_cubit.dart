import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/models/weather_forecast.dart';
import 'package:weather_app/data/repository/weather_info_repo.dart';
import 'package:geolocator/geolocator.dart';
import '../../constants/strings.dart';
import '../../data/models/weather_info.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final WeatherInfo_Repo weatherInfo_Repo;
  Weather_Info? weather_info;
  Weather_Forecast? weather_forecast;
  Position? location;

  HomePageCubit(this.weatherInfo_Repo) : super(HomePageInitial());

  Future<Position?> detLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return Geolocator.getCurrentPosition();
  }

  Weather_Info? getWeatherInfo() {
    try {
      detLocation().then((value) {
        weatherInfo_Repo
            .getWeatherInfo(value!.latitude, value.longitude, apiKey)
            .then((info) {
          emit(WeatherLoaded(info));
          weather_info = info;
        });
      });
    } catch (e) {
      rethrow;
    }

    return weather_info;
  }

  Weather_Forecast? getForecastInfo() {
    try {
      detLocation().then((value) => weatherInfo_Repo
              .getForecastInfo(value!.latitude, value.longitude, apiKey)
              .then((forecast) {
            emit(ForecastLoaded(forecast));
            weather_forecast = forecast;
          }));
    } catch (e) {
      rethrow;
    }
    return weather_forecast;
  }
}
