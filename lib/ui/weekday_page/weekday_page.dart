import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/daily_weath_model/daily_model.dart';

class WeekDayPage extends StatefulWidget {
  const WeekDayPage({super.key});

  @override
  State<WeekDayPage> createState() => _WeekDayPageState();
}

class _WeekDayPageState extends State<WeekDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              future:
                  ApiProvider().fetchWeatherDataDaily(lat: 15.51, long: 52.51),
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  WeatherbyDays days = snapshot.data;
                  List<Daily> dayy = days.daily;
                  return SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ListView.builder(
                      itemCount: dayy.length,
                      itemBuilder: (BuildContext context, int index) {
                        Daily day = dayy[index];

                        return Container(
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
                              Image.network(
                                "https://openweathermap.org/img/wn/${day.weather[0].icon}@2x.png",
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                ;
              },
            ),
          ],
        ),
      ),
    );
  }
}
