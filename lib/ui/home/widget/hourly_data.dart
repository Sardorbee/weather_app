
import 'package:flutter/material.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/hourly_model/hourly.dart';
import 'package:weather_app/utils/constants.dart';

class HourlyWeatherDataa extends StatelessWidget {
  const HourlyWeatherDataa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiProvider()
          .fetchWeatherDataByHour(lat: 91.45, long: 65.45),
      builder:
          (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}'));
        } else {
          WeatherbyHourModel data = snapshot.data;
          List<Hourly> hours = data.hourly;

          return Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hours.length,
              itemBuilder:
                  (BuildContext context, int index) {
                Hourly hour = hours[index];
                return Container(
                  padding: EdgeInsets.all(3),
                  margin:
                      EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: const Color.fromARGB(
                          120, 184, 187, 203)),
                  height: 60,
                  width: 60,
                  child: Column(
                    children: [
                      Text(
                        parseUnixTimestamp(hour.dt)
                            .toString()
                            .substring(11, 16),
                        style: TextStyle(fontSize: 12),
                      ),
                      Image.network(
                          "https://openweathermap.org/img/wn/${hour.weather[0].icon}@2x.png"),
                      Text(
                        "${hour.temp.toString()}°C",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
