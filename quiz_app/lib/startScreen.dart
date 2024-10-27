import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  Widget build(context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opacity(
        //   opacity: 0.5,
        //   child: Image.asset('assets/images/quiz-logo.png',width: 300,)),
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 300,
          color:const  Color.fromARGB(122, 236, 230, 227),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Me Banunga Krorpati",
          style:GoogleFonts.lato(
              color: Colors.white,
              fontSize: 25
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        OutlinedButton.icon(
            onPressed: startQuiz,
            icon: const Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
            label: const Text(
              "Start Quiz",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ))
      ],
    ));
  }
}
