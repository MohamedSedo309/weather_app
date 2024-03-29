import 'package:flutter/material.dart';

const baseURL = "https://api.openweathermap.org/data/2.5/";
const apiKey = "2591bd9df2ff7edead5df15cd49833b2";
const home_screen = '/';
const weather_next_days_screen = '/weather_next_days_screen';

String convertTempkelvinToCelsius(double kelvin) {
  return (kelvin - 273.15).toStringAsFixed(1);
}

String convertTempkelvinToCelsiusINT_ONLY(double kelvin) {
  double d = kelvin - 273.15;
  int i = d.toInt();
  return i.toString();
}

Widget getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return Image.asset('assets/images/1.png');
    case >= 300 && < 400:
      return Image.asset('assets/images/2.png');
    case >= 500 && < 600:
      return Image.asset('assets/images/3.png');
    case >= 600 && < 700:
      return Image.asset('assets/images/4.png');
    case >= 700 && < 800:
      return Image.asset('assets/images/5.png');
    case == 800:
      return Image.asset('assets/images/6.png');
    case > 800 && <= 804:
      return Image.asset('assets/images/7.png');
    default:
      return Image.asset('assets/images/7.png');
  }
}

class MyColors {
  static const myBlack = Colors.black;
  static const myGrey = Color(0xff343A40);
  static const myWhite = Color.fromRGBO(238, 238, 238, 1);
}
