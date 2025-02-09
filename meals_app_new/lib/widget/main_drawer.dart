import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectDrawer});

  final void Function(String msg) onSelectDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            child: Row(
              children: [
                const Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "Cooking Up !",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Meals",
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelectDrawer("Meals");
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            title: Text(
              "Filters",
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              onSelectDrawer("Filters");
            },
          ),
        ],
      ),
    );
  }
}
