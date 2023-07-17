import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';
import 'package:weather_app/services/network/models/hourly_model/hourly.dart';
import 'package:weather_app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d').format(now);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topLeft,
              // end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 149, 154, 231),
                Color.fromARGB(255, 43, 60, 136),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.density_medium,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // begin: Alignment.topLeft,
            // end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 149, 154, 231),
              Color.fromARGB(255, 43, 60, 136),
            ],
          ),
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: ApiProvider().fetchWeatherData("Toshkent"),
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
                        Row(
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
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: const Color.fromARGB(120, 184, 187, 203)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SvgPicture.asset(
                                      'assets/wind.svg',
                                      height: 150,
                                    ),
                                  ),
                                  const Text(
                                    "Wind",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ],
                              ),
                              Text(
                                "${data.wind.speed.toString()} km/h",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: const Color.fromARGB(120, 184, 187, 203)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 44,
                                    child: SvgPicture.asset(
                                      'assets/humdity.svg',
                                    ),
                                  ),
                                  const Text(
                                    "Humidity",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ],
                              ),
                              Text(
                                "${data.main.humidity.toString()} %",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Today',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Tomorrow',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Text(
                                    'Next 7 days',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FutureBuilder(
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
                                height: 80,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hours.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Hourly hour = hours[index];
                                    return Container(
                                      height: 40,
                                      width: 40,
                                      child: Column(
                                        children: [
                                          Text(parseUnixTimestamp(hour.dt)
                                              .toString()
                                              .substring(11, 17)),
                                          Image.network("https://openweathermap.org/img/wn/${hour.weather[0].icon}@2x.png"),
                                          Text(hour.temp.toString()),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
