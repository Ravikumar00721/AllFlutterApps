import "package:flutter/material.dart";
import "package:second_app/rolldice.dart";
// import "package:second_app/textwidget.dart";

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.colors});
  final List<Color> colors;
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: colors,
        begin: startAlignment,
        end: endAlignment,
      )),
      child:const Center(
        child: DiceRoller(),
      ),
    );
  }
}
