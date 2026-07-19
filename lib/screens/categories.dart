import 'package:flutter/material.dart';
import 'package:meal_tracker/dummy/dummy_data.dart';
import 'package:meal_tracker/widgets/category/category_grid_item.dart';

import '../models/category/category.dart';
import 'meal/meals.dart';

/// Here the category selection will be handled
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCategory(BuildContext context, Category category) {
    var meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: meals
        ))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your category')),
      body: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for(var cat in availableCategories)
            CategoryGridItem(
                category: cat,
                onSelectCategory: ()  => _selectCategory(context, cat),
            )
        ],
      ),
    );
  }
}
