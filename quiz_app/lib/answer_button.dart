import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({required this.answer, required this.ontap, super.key});

  final String answer;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding:const  EdgeInsets.symmetric(horizontal: 40,vertical: 10),
        backgroundColor:const  Color.fromARGB(255, 7, 155, 223),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))
      ),
      onPressed: ontap,
      child: Text(answer,textAlign: TextAlign.center,), // Removed const from here
    );
  }
}
