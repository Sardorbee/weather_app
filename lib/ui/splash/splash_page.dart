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
    LocationData? currentLocation = await location.getLocation();
    PermissionStatus permissionStatus = await location.requestPermission();
    if (permissionStatus == PermissionStatus.granted) {
      LocationData? locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
        lat = currentLocation!.latitude;
        lon = currentLocation!.longitude;
      });
      Future.delayed(Duration(seconds: 2), () {
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
      body: Center(
        child: FlutterLogo(
          size: 150.0, // Customize the size of the logo
        ),
      ),
    );
  }
}
