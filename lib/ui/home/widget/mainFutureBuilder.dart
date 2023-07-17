
import 'package:flutter/material.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';
import 'package:weather_app/ui/home/widget/celciusRow.dart';
import 'package:weather_app/ui/home/widget/hourly_data.dart';
import 'package:weather_app/ui/home/widget/humidityCont.dart';
import 'package:weather_app/ui/home/widget/threerows.dart';
import 'package:weather_app/ui/home/widget/windCont.dart';

class MainFutureBuilder extends StatelessWidget {
  double? lat;
  double ?lon;
   MainFutureBuilder({
    super.key,
    required this.formattedDate,
    required this.lat,required this.lon
  });

  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiProvider().fetchWeatherData( lat:  lat.toString(), lon: lon.toString(), units: 'metric'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          WeatherModel data = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(25),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.name},",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20),
                ),
                Text(
                  data.sys.country,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(color: Colors.white),
                ),
                CelciusRow(data: data),
                const SizedBox(height: 10),
                windContainer(data: data),
                const SizedBox(
                  height: 10,
                ),
                WorHcontainer(data: data),
                const SizedBox(
                  height: 150,
                ),
                weekrowsthree(),
                SizedBox(
                  height: 5,
                ),
                // HourlyWeatherDataa(),
              ],
            ),
          );
        }
      },
    );
  }
}
