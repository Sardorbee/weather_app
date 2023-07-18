import 'package:flutter/material.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';
import 'package:weather_app/services/network/models/universal_data.dart';
import 'package:weather_app/ui/home/widget/celciusRow.dart';
import 'package:weather_app/ui/home/widget/hourly_data.dart';
import 'package:weather_app/ui/home/widget/humidityCont.dart';
import 'package:weather_app/ui/home/widget/threerows.dart';
import 'package:weather_app/ui/home/widget/windCont.dart';

class MainFutureBuilder extends StatelessWidget {
  double? lat;
  double? lon;
  String? q;
  MainFutureBuilder(
      {super.key,
      required this.formattedDate,
      required this.lat,
      required this.lon,
      this.q});

  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    print(lat);
    print(lon);
    print(q);

    return FutureBuilder(
      future: ApiProvider().fetchWeatherData(
          lat: lat.toString(), lon: lon.toString(), units: 'metric', q: q),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          UniversalData dataa = snapshot.data;
          WeatherModel data = dataa.data;
          return Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.name},",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  data.sys.country,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
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
                const weekrowsthree(),
                const SizedBox(
                  height: 5,
                ),
                HourlyWeatherDataa(
                  lat: lat!,
                  lon: lon!,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
