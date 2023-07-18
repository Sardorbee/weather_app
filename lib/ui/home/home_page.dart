import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/home/search/weathsearch.dart';
import 'package:weather_app/ui/home/widget/mainFutureBuilder.dart';

class HomePage extends StatefulWidget {
  double? lat;
  double? lon;

  HomePage({super.key, required this.lat, required this.lon});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? queryy;

  void _showSearch() async {
    final selectedQuery = await showSearch<String>(
      context: context,
      delegate: WeatherSearchDelegate(),
    );
    print(selectedQuery);

    // Use the selected query here if needed
    if (selectedQuery != null && selectedQuery.isNotEmpty) {
      print(queryy);

      setState(() {
        queryy = selectedQuery; // Update the queryy with the selected query
      });
      print(queryy);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
          onPressed: _showSearch,
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
            MainFutureBuilder(
                formattedDate: formattedDate,
                lat: widget.lat,
                lon: widget.lon,
                q: queryy),
          ],
        ),
      ),
    );
  }
}
