import 'package:flutter/material.dart';
import 'package:meals_app_new/screen/details_screen.dart';
import 'package:meals_app_new/widget/meal_item.dart';

import '../model/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => DetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content =
        ListView.builder(itemBuilder: (ctx, index) => Text(meals[index].title));

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Kahan Khatam....",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Try Selecting a different Screen",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }
    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealsItem(
                meal: meals[index],
                onSelectMeal: (meal) {
                  selectMeal(context, meal);
                },
              ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
