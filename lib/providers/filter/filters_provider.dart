import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_tracker/providers/meal/meals_provider.dart';

import '../../models/meal/meal.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
        Filter.lactoseFree: false,
      });

  void setFilters(Map<Filter, bool> newFilters) {
   state = newFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
    );


bool isFilterMatching(Filter filter, bool value, Map<Filter, bool> activeFilters) {
  if (!activeFilters[filter]!) return true;
  return value;
}

bool _isMealMatchingFilter(Meal meal, Map<Filter, bool> activeFilters) {
  return isFilterMatching(Filter.glutenFree, meal.isGlutenFree, activeFilters) &&
      isFilterMatching(Filter.vegetarian, meal.isVegetarian, activeFilters) &&
      isFilterMatching(Filter.vegan, meal.isVegan, activeFilters) &&
      isFilterMatching(Filter.lactoseFree, meal.isLactoseFree, activeFilters);
}

final filteredMealsProvider = Provider((ref) {
  var meals = ref.watch(mealsProvider);
  var activeFilters = ref.watch(filtersProvider);

  return meals
      .where((m) => _isMealMatchingFilter(m, activeFilters))
      .toList();
});