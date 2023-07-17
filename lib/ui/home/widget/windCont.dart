
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';

class windContainer extends StatelessWidget {
  const windContainer({
    super.key,
    required this.data,
  });

  final WeatherModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
