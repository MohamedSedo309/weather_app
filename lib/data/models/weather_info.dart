class Weather_Info {
  late String city;
  double? lat;
  double? lon;
  late int sunset;
  late int sunrise;
  late double temp;
  late String icon;
  late double feelLike_temp;
  late double max_temp;
  late double min_temp;
  late String descrip;
  late String description;
  late double wind_speed;
  late int? code;
  late Map<String, double>? rain;

  Weather_Info.fromjson(Map<String, dynamic> json) {
    List<dynamic> weatherData = json['weather'];
    Map<String, dynamic> weather = weatherData.isNotEmpty ? weatherData[0] : {};
    city = json["name"];
    lat = double.parse(json["coord"]["lat"].toString());
    lon = double.parse(json["coord"]["lon"].toString());
    sunset = json["sys"]["sunset"];
    sunrise = json["sys"]["sunrise"];
    temp = double.parse(json["main"]["temp"].toString());
    icon = weather["icon"];
    feelLike_temp = double.parse(json["main"]["feels_like"].toString());
    max_temp = double.parse(json["main"]["temp_max"].toString());
    min_temp = double.parse(json["main"]["temp_min"].toString());
    code = weather["id"];
    descrip = weather["main"];
    description = weather["description"];
    wind_speed = double.parse(json["wind"]["speed"].toString());
    //rain = json["rain"];
  }
}
