import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_new/provider/favorites_provider.dart';
import 'package:meals_app_new/provider/meals_provider.dart';
import 'package:meals_app_new/screen/categories.dart';
import 'package:meals_app_new/screen/filterScreen.dart';
import 'package:meals_app_new/screen/meals.dart';
import 'package:meals_app_new/widget/main_drawer.dart';

import '../provider/filter_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.veganFree: false,
  Filter.vegetarianFree: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // final List<Meal> _favoriteMeal = [];

  // void _toggleMealFavoriteSatus(Meal meal) {
  //   final isexisting = _favoriteMeal.contains(meal);
  //
  //   if (isexisting) {
  //     setState(() {
  //       _favoriteMeal.remove(meal);
  //     });
  //     showMesaage("Man Bhar Gya!!!!!");
  //   } else {
  //     setState(() {
  //       _favoriteMeal.add(meal);
  //     });
  //     showMesaage("Added to Favorite");
  //   }
  // }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );

      if (result != null) {
        print(result); // This should now print the selected filters correctly
      } else {
        print("No filters returned.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.veganFree]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activepage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteSatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoritemeal = ref.watch(favoritesMealsProvider);
      activepage = MealScreen(
        title: null,
        meals: favoritemeal,
        // onToggleFavorite: _toggleMealFavoriteSatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectDrawer: _setScreen,
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
    );
  }
}
