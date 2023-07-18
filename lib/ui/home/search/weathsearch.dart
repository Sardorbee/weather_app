import 'package:flutter/material.dart';
import 'package:weather_app/services/network/api/api_provider.dart';
import 'package:weather_app/services/network/models/universal_data.dart';

class WeatherSearchDelegate extends SearchDelegate<String> {
  Set<String> _previousSearches = {};

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show the results based on the selected query.
    // return FutureBuilder<UniversalData>(
    //   future: ApiProvider().fetchWeatherData(lat: "", lon: "", q: query),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (snapshot.hasError) {
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     } else if (snapshot.hasData) {
    //       final weatherData = snapshot.data!;
    //       return buildWeatherUI(weatherData);
    //     } else {
    //       return Center(child: Text('No results found'));
    //     }
    //   },
    // );
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions based on the user's input.
    final List<String> suggestions = _previousSearches
        .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return FutureBuilder<UniversalData>(
        future: ApiProvider()
            .fetchWeatherData(lat: "41.65", lon: "91.51", q: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            if (snapshot.data!.error.isEmpty) {
              final weatherData = snapshot.data!;
              return InkWell(
                onTap: () {
                  close(context, query);
                },
                child: buildWeatherUI(
                  weatherData,
                ),
              );
            } else {
              return Center(
                child: Text(snapshot.data!.error),
              );
            }
          } else {
            return Center(child: Text('No results found'));
          }
        });
    //
    //
    // ListView.builder(
    //   itemCount: suggestions.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(suggestions[index]),
    //       onTap: () {
    //         query = suggestions[index]; // Update the query with the selected suggestion
    //         showResults(context); // Show the results for the selected suggestion
    //       },
    //     );
    //   },
    // );
  }

  @override
  String get query => super.query;

  @override
  set query(String newQuery) {
    super.query = newQuery;
    if (newQuery.isNotEmpty) {
      _previousSearches.add(newQuery);
    }
  }

  Widget buildWeatherUI(UniversalData weatherData) {
    // Implement the UI to display the weather data.
    // For example, you can use a Column with Text widgets to show temperature, humidity, etc.
    return Center(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(weatherData.data.name),
              trailing: Text(weatherData.data.main.temp.toString()),
            ),
            // Add more weather data fields as needed.
          ],
        ),
      ),
    );
  }
}
