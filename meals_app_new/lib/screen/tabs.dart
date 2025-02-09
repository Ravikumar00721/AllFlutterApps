import 'package:flutter/material.dart';
import 'package:meals_app_new/screen/categories.dart';
import 'package:meals_app_new/screen/filterScreen.dart';
import 'package:meals_app_new/screen/meals.dart';
import 'package:meals_app_new/widget/main_drawer.dart';

import '../model/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Meal> _favoriteMeal = [];

  void _toggleMealFavoriteSatus(Meal meal) {
    final isexisting = _favoriteMeal.contains(meal);

    if (isexisting) {
      setState(() {
        _favoriteMeal.remove(meal);
      });
      showMesaage("Man Bhar Gya!!!!!");
    } else {
      setState(() {
        _favoriteMeal.add(meal);
      });
      showMesaage("Added to Favorite");
    }
  }

  void showMesaage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _setScreen(String idenifier) async {
    Navigator.of(context).pop();
    if (idenifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FiltersScreen()));

      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activepage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteSatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activepage = MealScreen(
        title: null,
        meals: _favoriteMeal,
        onToggleFavorite: _toggleMealFavoriteSatus,
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
