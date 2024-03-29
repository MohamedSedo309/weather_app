part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

class WeatherLoaded extends HomePageState {
  final Weather_Info weather_info;

  WeatherLoaded(this.weather_info);
}

class ForecastLoaded extends HomePageState {
  final Weather_Forecast weather_forecast;

  ForecastLoaded(this.weather_forecast);
}
