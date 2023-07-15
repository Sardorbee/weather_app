import 'package:http/http.dart' as http;
import 'package:weather_app/services/network/models/weather_model.dart';
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
}
