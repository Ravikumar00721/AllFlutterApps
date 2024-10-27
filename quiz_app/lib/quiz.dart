import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/startScreen.dart';
import 'package:quiz_app/resultScreen.dart';

class QuizDart extends StatefulWidget {
  const QuizDart({super.key});

  @override
  State<QuizDart> createState() {
    return _QuizDart();
  }
}

class _QuizDart extends State<QuizDart> {
  List<String> selectedAnswer = [];
  var activeScreen = "start_screen";

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == question.length) {
      setState(() {
        activeScreen = 'result_screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];  // Clear the selected answers
      activeScreen = 'start_screen';  // Go back to the start screen
    });
  }

  void switchScreen() {
    setState(() {
      activeScreen = "question_screen";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question_screen') {
      screenWidget = QuestionDart(onSelectedAnswer: chooseAnswer);
    }

    if (activeScreen == 'result_screen') {
       screenWidget = Resultscreen(chosenAnswer: selectedAnswer, onRestart: restartQuiz);
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 22, 173, 243),
                Color.fromARGB(255, 54, 73, 248),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
