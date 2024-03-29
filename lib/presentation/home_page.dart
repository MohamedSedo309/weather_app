import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/bessuness_logic/cubit/home_page_cubit.dart';
import 'package:weather_app/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather_app/data/models/weather_info.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  late Weather_Info weather_info;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageCubit>(context).getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: MyColors.myBlack,
      extendBodyBehindAppBar: true,
      body: buildBlocWedgit(),
    );
  }

  Widget buildBlocWedgit() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (BuildContext context, state) {
        if (state is WeatherLoaded) {
          weather_info = state.weather_info;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndecator();
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 600,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFAB40),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(color: Colors.transparent),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📍 ${weather_info.city}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateTime.now().hour >= 18 ? "Good Night" : "Good Morning",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      height: 250,
                      width: 500,
                      child: getWeatherIcon(weather_info.code == null
                          ? 1000
                          : weather_info.code!),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${convertTempkelvinToCelsius(weather_info.temp)}°C",
                      style: const TextStyle(
                        color: MyColors.myWhite,
                        fontSize: 55,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Feels like: ${convertTempkelvinToCelsius(weather_info.temp)}°C",
                      style: const TextStyle(
                        color: MyColors.myWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      weather_info.descrip,
                      style: const TextStyle(
                        color: MyColors.myWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      weather_info.description,
                      style: const TextStyle(
                        color: MyColors.myWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: Text(
                    formatDate(DateTime.now()),
                    style: const TextStyle(
                      color: MyColors.myWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, weather_next_days_screen);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            "Next Days ",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: const [
                              Colors.deepPurple,
                              Colors.yellowAccent,
                            ],
                          ),
                          const Icon(
                            Icons.arrow_circle_right_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/11.png",
                            scale: 8,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Sunrise",
                                style: TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                convertTime(weather_info.sunrise),
                                style: const TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/12.png",
                            scale: 8,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Sunset",
                                style: TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                convertTime(weather_info.sunset),
                                style: const TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/13.png",
                            scale: 8,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Max Temp.",
                                style: TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "${convertTempkelvinToCelsius(weather_info.max_temp)}°C",
                                style: const TextStyle(
                                  color: MyColors.myWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/14.png",
                            scale: 8,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              const Text(
                                "Min. Temp.",
                                style: TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "${convertTempkelvinToCelsius(weather_info.min_temp)}°C",
                                style: const TextStyle(
                                    color: MyColors.myWhite,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showLoadingIndecator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myWhite,
      ),
    );
  }

  String convertTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? ' am' : ' pm';
    return '$hour:$minute$period';
  }

  String formatDate(DateTime dateTime) {
    List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    int weekdayIndex = dateTime.weekday - 1;

    int day = dateTime.day;

    int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;

    int minute = dateTime.minute;

    String period = dateTime.hour < 12 ? ' am' : ' pm';

    String formattedDate =
        '${weekdays[weekdayIndex]} $day - $hour:${minute.toString().padLeft(2, '0')}$period';

    return formattedDate;
  }
}
