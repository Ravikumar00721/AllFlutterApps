import 'package:flutter/material.dart';
import 'package:meals_app_new/data/dummy_data.dart';
import 'package:meals_app_new/model/Category_Model.dart';
import 'package:meals_app_new/screen/meals.dart';
import 'package:meals_app_new/widget/category_grid_item.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectcategory(BuildContext context, CatModel category) {
    // Filter available meals based on the selected category
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigate to MealScreen with the filtered meals
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealScreen(
        title: category.title,
        meals: filteredMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in foodCategories)
            CategoryGridItem(
              category: category,
              onSelectScreen: () {
                _selectcategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOut)),
        child: child,
      ),
    );
  }
}
