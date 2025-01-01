import 'package:flutter/material.dart';

class CatogariesScreen extends StatelessWidget {
  const CatogariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick YOur Categories"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: const [
          Text("1" ,style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          Text("2",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          Text("3",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          Text("4",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          Text("5",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
          Text("6",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        ],
      ),
    );
  }
}
