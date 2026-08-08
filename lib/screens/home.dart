import 'package:country_games/data/countries_data.dart';
import 'package:country_games/screens/list.dart';
import 'package:flutter/material.dart';
import 'flag_quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Guess the Flag')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Start'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => FlagQuizScreen(
                            countries: countries,
                          )),
                );
              },
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CountryList()),
                );
              },
              child: Text('List of Flags'),
            ),
          ],
        ),
      ),
    );
  }
}
