import 'package:country_games/controllers/quiz_controller.dart';
import 'package:country_games/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlagQuizScreen extends StatelessWidget {
  final List<Map<String, String>> countries;

  const FlagQuizScreen({super.key, required this.countries});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FlagQuizController(countries));

    return WillPopScope(
        onWillPop: () async {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Close?'),
                content: const Text('Are you sure?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.delete<FlagQuizController>();
                      Navigator.pop(context, true);
                    },
                    child: const Text('close'),
                  ),
                ],
              );
            },
          );
          return shouldExit ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Guess the Flag'),
            actions: [
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        '${controller.currentIndex.value + 1} / 20',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )),
            ],
          ),
          body: Obx(() {
            final question = controller.currentQuestion;
            final options = controller.currentOptions;
            final selected = controller.selectedAnswer!.value;
            final checked = controller.answerChecked.value;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlagImage(flagUrl: question['flag']!),
                const SizedBox(height: 20),
                ...options.map((option) {
                  final isCorrect = option['name'] == question['name'];
                  final isSelected = option['name'] == selected;
                  Color color = Colors.grey.shade200;

                  if (checked) {
                    if (isCorrect) {
                      color = Colors.green;
                    } else if (isSelected) {
                      color = Colors.red;
                    }
                  }

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (!controller.answerChecked.value) {
                          controller.selectedAnswer.value = option['name']!;
                          controller.checkAnswer();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: Text('${option['name']}'),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.selectedAnswer == RxString('')
                      ? null
                      : controller.nextQuestion,
                  child: const Text('Next'),
                ),
              ],
            );
          }),
        ));
  }
}
