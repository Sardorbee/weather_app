import 'package:flutter/material.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/weather_model.dart';
import 'package:weather_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: ApiProvider().fetchWeatherData("termiz"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                WeatherModel data = snapshot.data;
                return Center(
                  child: Column(
                    children: [
                      Text(data.base),
                      Text(data.name),
                      Text(data.clouds.toString()),
                      Text(data.cod.toString()),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lon.toString()),
                      Text(parseUnixTimestamp(data.dt).toString()),
                      Text(data.id.toString()),
                      Text(data.main.feelsLike.toString()),
                      Text(data.main.humidity.toString()),
                      Text(data.main.pressure.toString()),
                      Text(data.main.temp.toString()),
                      Text(data.main.tempMax.toString()),
                      Text(data.main.tempMin.toString()),
                      Text(data.visibility.toString()),
                      Text(data.sys.id.toString()),
                      Text(data.sys.country.toString()),
                      Text(parseUnixTimestamp(data.sys.sunrise).toString()),
                      Text(parseUnixTimestamp(data.sys.sunset).toString()),
                      Text(data.sys.type.toString()),
                      Text(data.timezone.toString()),
                      Text(data.weather[0].description.toString()),
                      Image.network(
                        "https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png",
                      ),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lat.toString()),
                      Text(data.coord.lat.toString()),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
