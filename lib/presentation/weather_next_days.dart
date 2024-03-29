import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:weather_app/bessuness_logic/cubit/home_page_cubit.dart';
import 'package:weather_app/data/models/weather_forecast.dart';
import 'package:intl/intl.dart';
import '../constants/strings.dart';

class Weather_NextDays_page extends StatefulWidget {
  const Weather_NextDays_page({Key? key}) : super(key: key);

  @override
  State<Weather_NextDays_page> createState() => _Weather_NextDays_pageState();
}

class _Weather_NextDays_pageState extends State<Weather_NextDays_page> {
  late Weather_Forecast weather_forecast;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageCubit>(context).getForecastInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: MyColors.myBlack,
      extendBodyBehindAppBar: true,
      body: buildBlocWedgit(),
    );
  }

  buildBlocWedgit() {
    return BlocBuilder<HomePageCubit, HomePageState>(
        builder: (BuildContext context, state) {
      if (state is ForecastLoaded) {
        weather_forecast = state.weather_forecast;
        return buildLoadedWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myWhite,
      ),
    );
  }

  Widget buildLoadedWidgets() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(4, -1.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blue,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(4, -0.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(1.8, -1.2),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("assets/images/7.png"),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.arrow_circle_left_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "This Week",
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        height: 600,
                        child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                            shrinkWrap: true,
                            itemCount: weather_forecast.temp.length,
                            separatorBuilder: (ctx, index) {
                              return const Divider(
                                thickness: 1,
                                color: Colors.white,
                              );
                            },
                            itemBuilder: (ctx, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        formatDatetogetDay(
                                            weather_forecast.date[index]),
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        formatDatetogetDateandTime(
                                            weather_forecast.date[index]),
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: getWeatherIcon(
                                            weather_forecast.code[index] == null
                                                ? 1000
                                                : weather_forecast
                                                    .code[index]!),
                                      ),
                                      Text(
                                        weather_forecast.description[index],
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${convertTempkelvinToCelsiusINT_ONLY(weather_forecast.temp[index])}°C",
                                    style: const TextStyle(
                                      color: MyColors.myWhite,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              );
                            }),
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
}

String formatDatetogetDateandTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('d/M  h a').format(dateTime);
  return formattedDate;
}

String formatDatetogetDay(String date) {
  DateTime dateTime = DateTime.parse(date);
  String dayName = DateFormat.E().format(dateTime);
  return dayName;
}
