import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repository/weather_info_repo.dart';
import 'package:weather_app/data/web_services/weather_webServices.dart';
import 'package:weather_app/presentation/weather_next_days.dart';
import 'bessuness_logic/cubit/home_page_cubit.dart';
import 'constants/strings.dart';
import 'presentation/home_page.dart';

class App_Router {
  late HomePageCubit homePageCubit;

  App_Router() {
    WeatherInfo_Repo weatherInfo_Repo = WeatherInfo_Repo(Weather_WebServices());
    homePageCubit = HomePageCubit(weatherInfo_Repo);
  }

  // ignore: body_might_complete_normally_nullable
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (home_screen):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => homePageCubit,
            child: const Home_page(),
          ),
        );
      case (weather_next_days_screen):
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => homePageCubit,
            child: const Weather_NextDays_page(),
          ),
        );
    }
  }
}
