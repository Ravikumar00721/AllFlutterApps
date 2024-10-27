import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';

import 'package:quiz_app/data/questions.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionDart extends StatefulWidget {
  const QuestionDart({super.key, required this.onSelectedAnswer});

  final ValueChanged<String> onSelectedAnswer;

  @override
  State<QuestionDart> createState() {
    return _QuestionDart();
  }
}

class _QuestionDart extends State<QuestionDart> {
  var currentQuestion = 0;

  void answered(String selectedAnswer) {
    widget.onSelectedAnswer(selectedAnswer);
    setState(() {
      currentQuestion++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentquestion = question[currentQuestion];
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentquestion.text,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ...currentquestion.getShuffledList().map((answer) {
              return AnswerButton(
                answer: answer,
                ontap: () => answered(answer),
              );
            }),
          ],
        ),
      ),
    );
  }
}
