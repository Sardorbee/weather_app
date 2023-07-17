
import 'package:flutter/material.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';

class CelciusRow extends StatelessWidget {
  const CelciusRow({
    super.key,
    required this.data,
  });

  final WeatherModel data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network(
          "https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png",
          height: 150,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.main.temp.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontSize: 45),
                ),
                Text(
                  data.weather[0].main,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            const Text(
              " ° C",
              style: TextStyle(
                  color: Colors.white, fontSize: 40),
            ),
          ],
        ),
      ],
    );
  }
}
