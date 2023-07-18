import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/services/network/api/api_utils.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';
import 'package:weather_app/services/network/models/daily_weath_model/daily_model.dart';
import 'package:weather_app/services/network/models/hourly_model/hourly.dart';
import 'package:weather_app/services/network/models/universal_data.dart';
import 'package:weather_app/utils/constants.dart';

class ApiProvider {
  Future<UniversalData> fetchWeatherData(
      {String units = "metric",
      required String lat,
      required String lon,
      String? q}) async {
    final path2 = "/data/2.5/weather";
    final urll = Uri.https(baseUrl, path2, {
      "appid": apiKey,
      // "appid": "139d82d53b7f20c0a44c1bc27377f9ff",
      'q': q,
      "lat": lat,
      "lon": lon,
      "units": units,
    });
    

    
    try {
      http.Response response = await http.get(urll);
      if (response.statusCode == HttpStatus.ok) {
        return UniversalData(
            data: WeatherModel.fromJson(jsonDecode(response.body)));
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalData(error: "Internet Error!");
    } on FormatException {
      return UniversalData(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR:$err. ERROR TYPE: ${err.runtimeType}");
      return UniversalData(error: err.toString());
    }
  }

  Future<WeatherbyDays> fetchWeatherDataDaily({
    required double lat,
    required double long,
  }) async {
    final url = Uri.https(baseUrl, path, {
      "appid": "649ff9f2558d2c45135158b30bc262d8",
      // "appid": "139d82d53b7f20c0a44c1bc27377f9ff",
      "lat": lat.toString(),
      "lon": long.toString(),
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

  final String baseUrl = 'api.openweathermap.org';
  final String path = '/data/2.5/onecall';

  Future<WeatherbyHourModel> fetchWeatherDataByHour({
    required double lat,
    required double long,
  }) async {
    final url = Uri.https(baseUrl, path, {
      "appid": "649ff9f2558d2c45135158b30bc262d8",
      // "appid": "139d82d53b7f20c0a44c1bc27377f9ff",
      "lat": lat.toString(),
      "lon": long.toString(),
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
