import 'package:flutter/material.dart';
import 'package:meal_tracker/dummy/dummy_data.dart';
import 'package:meal_tracker/screens/categories.dart';
import 'package:meal_tracker/screens/filter/filters.dart';
import 'package:meal_tracker/screens/meal/meals.dart';
import 'package:meal_tracker/widgets/main_drawer.dart';

import '../models/meal/meal.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
        _showInfoMessage("Removed meal ${meal.title} from favorites");
      });
    } else {
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("Marked meal ${meal.title} as favorite");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    //close drawer
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      var result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  bool isFilterMatching(Filter filter, bool value) {
    if (!_selectedFilters[filter]!) return true;
    return value;
  }

  bool _isMealMatchingFilter(Meal meal) {
    return isFilterMatching(Filter.glutenFree, meal.isGlutenFree) &&
        isFilterMatching(Filter.vegetarian, meal.isVegetarian) &&
        isFilterMatching(Filter.vegan, meal.isVegan) &&
        isFilterMatching(Filter.lactoseFree, meal.isLactoseFree);
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(_isMealMatchingFilter).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
