class Weather_Forecast {
  List<double> temp = [];
  List<String> date = [];
  List<String> description = [];
  List<int?> code = [];

  Weather_Forecast.fromjson(Map<String, dynamic> json) {
    List<dynamic> forecast = json["list"];
    forecast.forEach((day) {
      temp.add(double.parse(day["main"]["temp"].toString()));
      code.add(int.parse(day["weather"][0]["id"].toString()));
      description.add(day["weather"][0]["main"]);
      date.add(day["dt_txt"]);
    });
  }
}
