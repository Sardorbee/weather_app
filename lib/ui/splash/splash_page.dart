import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/ui/home/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Location location = Location();
  double? lat;
  double? lon;

  Future<void> retrieveLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    PermissionStatus permissionStatus = await location.requestPermission();
    // LocationData? currentLocation = await location.getLocation();

    if (permissionStatus == PermissionStatus.granted) {
      LocationData? currentLocation = await location.getLocation();
      setState(() {
        lat = currentLocation.latitude;
        lon = currentLocation.longitude;
      });
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      lat: lat,
                      lon: lon,
                    )));
      });
    }
  }

  @override
  void initState() {
    retrieveLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg.png',
          ),
          Image.asset(
            'assets/images/1.png',
          ),
          Center(
            child: Text(
              "Weather",
              style: TextStyle(fontSize: 60, color: Colors.cyan[700]),
            ),
          ),
        ],
      ),
    );
  }
}
