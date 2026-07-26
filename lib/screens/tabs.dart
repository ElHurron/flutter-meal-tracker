import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_tracker/providers/meal/favorites_provider.dart';
import 'package:meal_tracker/screens/categories.dart';
import 'package:meal_tracker/screens/filter/filters.dart';
import 'package:meal_tracker/screens/meal/meals.dart';
import 'package:meal_tracker/widgets/main_drawer.dart';

import '../providers/filter/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
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

  void _setScreen(String identifier) async {
    //close drawer
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    var meals = ref.watch(filteredMealsProvider);
    var favoriteMeals = ref.watch(favoriteMealsProvider);



    Widget activePage = CategoriesScreen(
      availableMeals: meals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
    );
  }
}
