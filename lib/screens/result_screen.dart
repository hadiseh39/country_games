import 'package:country_games/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.delete<FlagQuizController>();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Result')),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.deepPurple),
                  color: const Color.fromARGB(255, 240, 232, 253),
                ),
                child: Column(
                  children: [
                    Text(
                      'Quiz ended!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Score : $score / 20',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        Get.delete<FlagQuizController>();
                        Navigator.pop(context);
                        // back to home page
                      },
                      child: const Text('back'),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
