import 'dart:math';
import 'package:country_games/screens/result_screen.dart';
import 'package:get/get.dart';

class FlagQuizController extends GetxController {
  final List<Map<String, String>> allCountries;
  late List<Map<String, String>> selectedQuestions;

  // current index of the question
  final RxInt currentIndex = 0.obs;

  // Whether the current question has been answered
  final RxBool answerChecked = false.obs;

  // The answer selected by the user
  final RxString selectedAnswer = RxString('');

  // Total number of correct answers
  final RxInt correctAnswers = 0.obs;

  // The 4 options to display for the current question
  List<Map<String, String>> currentOptions = [];

  FlagQuizController(this.allCountries) {
    _generateQuiz();
  }

  void _generateQuiz() {
    // Shuffles the list of all countries and picks 20 random questions
    allCountries.shuffle();
    selectedQuestions = allCountries.take(20).toList();
    _generateOptions();
  }

  void _generateOptions() {
    // Generates 4 options for the current question (1 correct + 3 incorrect)
    final correct = selectedQuestions[currentIndex.value];
    final options = <Map<String, String>>[correct];

    while (options.length < 4) {
      final randomCountry = allCountries[Random().nextInt(allCountries.length)];
      if (!options.contains(randomCountry)) {
        options.add(randomCountry);
      }
    }

    options.shuffle();
    currentOptions = options;
  }

  // Getter to get the current question
  Map<String, String> get currentQuestion =>
      selectedQuestions[currentIndex.value];

  void selectAnswer(String answer) {
    selectedAnswer.value = answer;
  }

  void checkAnswer() {
    // Checks if the selected answer is correct and updates the score
    if (selectedAnswer.value == currentQuestion['name']) {
      correctAnswers.value++;
    }
    answerChecked.value = true;
  }

  void nextQuestion() {
    // Moves to the next question or shows the result screen if finished

    if (currentIndex.value < selectedQuestions.length - 1) {
      currentIndex.value++;
      answerChecked.value = false;
      selectedAnswer.value = '';
      _generateOptions();
    } else {
      Get.off(() => ResultScreen(score: correctAnswers.value));
    }
  }
}
