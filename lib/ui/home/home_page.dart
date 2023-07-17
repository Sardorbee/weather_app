import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/home/widget/mainFutureBuilder.dart';


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
            MainFutureBuilder(formattedDate: formattedDate),
          ],
        ),
      ),
    );
  }
}
