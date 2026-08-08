import 'package:country_games/data/countries_data.dart';
import 'package:country_games/widgets/image.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    final sortedCountries = List<Map<String, String>>.from(countries)
      ..sort((a, b) => a['name']!.compareTo(b['name']!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Flags'),
      ),
      body: ListView.builder(
        itemCount: sortedCountries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 231, 231, 231)),
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 240, 232, 253),
            ),
            child: ListTile(
              title: Text(sortedCountries[index]['name']!),
              subtitle: Text(sortedCountries[index]['capital']!),
              trailing: FlagImage(flagUrl: sortedCountries[index]['flag']!),
            ),
          );
        },
      ),
    );
  }
}
