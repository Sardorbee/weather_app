import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';
import 'package:weather_app/services/network/models/daily_weath_model/daily_model.dart';
import 'package:weather_app/services/network/models/hourly_model/hourly.dart';
import 'package:weather_app/utils/constants.dart';

class ApiProvider {
  Future<WeatherModel> fetchWeatherData(String cityName,
      {String units = "metric"}) async {
    final apiUrl = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?appid=$apiKey&q=$cityName&units=$units');
    final response = await http.get(apiUrl);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonBody = response.body;
      final weatherModel = weatherModelFromJson(jsonBody);
      return weatherModel;
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  Future<WeatherbyDays> fetchWeatherDataDaily() async {
    final url = Uri.https(baseUrl, path, {
      "appid": "139d82d53b7f20c0a44c1bc27377f9ff",
      "exclude": "minutely,current,hourly",
      "units": "metric",
    });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherbyDaysFromJson(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }

  final String baseUrl =
      'api.openweathermap.org'; 
  final String path = '/data/2.5/onecall'; 

  Future<WeatherbyHourModel> fetchWeatherDataByHour({
    required double lat,
    required double long,
  }) async {
    final url = Uri.https(baseUrl, path, {
      "appid": "139d82d53b7f20c0a44c1bc27377f9ff",
      "lat": '41.65',
      "lon": '65.848',
      "exclude": "minutely,current,daily",
      "units": "metric",
    });

    final response = await http.get(url);
    print(response.statusCode);

    if (response.statusCode == 200) {
    final decodedJson = json.decode(response.body);
    if (decodedJson != null) {
      return WeatherbyHourModel.fromJson(decodedJson);
    } else {
      throw Exception('Failed to decode JSON');
    }
  } else {
    throw Exception('Failed to fetch weather data');
  }
  }
}
