import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_tracker/models/meal/meal.dart';

class FavoriteMealsProvider extends StateNotifier<List<Meal>> {
  FavoriteMealsProvider() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state
          .where((m) => m.id != meal.id)
          .toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsProvider, List<Meal>>((ref) {
  return FavoriteMealsProvider();
});