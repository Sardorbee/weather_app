
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/services/network/models/current_weather_model/weather_model.dart';

class WorHcontainer extends StatelessWidget {
  const WorHcontainer({
    super.key,
    required this.data,
  });

  final WeatherModel data;

  @override
  Widget build(BuildContext context) {
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
          Text(
            "${data.main.humidity.toString()} %",
            style: const TextStyle(
                color: Colors.white, fontSize: 17),
          )
        ],
      ),
    );
  }
}
