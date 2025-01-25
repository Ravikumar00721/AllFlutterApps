import 'package:flutter/material.dart';
import 'package:meals_app_new/data/dummy_data.dart';
import 'package:meals_app_new/widget/category_grid_item.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Your Category"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          for (final category in foodCategories)
            CategoryGridItem(category: category)
        ],
      ),
    );
  }
}
