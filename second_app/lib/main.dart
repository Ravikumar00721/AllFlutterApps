import 'package:flutter/material.dart';
import 'package:second_app/gradient_conatainer.dart'; // Ensure this is the correct file path

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body:GradientContainer(
        colors: [
          Color.fromARGB(255, 1, 47, 255),
          Color.fromARGB(255, 17, 185, 252),
        ],
      ),
    ),
  ));
}
