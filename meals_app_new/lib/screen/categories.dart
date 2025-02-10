import 'package:flutter/material.dart';
import 'package:meals_app_new/data/dummy_data.dart';
import 'package:meals_app_new/model/Category_Model.dart';
import 'package:meals_app_new/screen/meals.dart';
import 'package:meals_app_new/widget/category_grid_item.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      // required this.onToggleFavorite,
      required this.availableMeals});
  // final void Function(Meal meal) onToggleFavorite;

  final List<Meal> availableMeals;

  void _selectcategory(BuildContext context, CatModel category) {
    final filtered_meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealScreen(
              title: category.title,
              meals: filtered_meals,
              // onToggleFavorite: onToggleFavorite,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in foodCategories)
          CategoryGridItem(
            category: category,
            onSelectScreen: () {
              _selectcategory(context, category);
            },
          )
      ],
    );
  }
}
