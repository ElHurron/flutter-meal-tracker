import 'package:flutter/material.dart';
import 'package:meal_tracker/dummy/dummy_data.dart';
import 'package:meal_tracker/widgets/category/category_grid_item.dart';

import '../models/category/category.dart';
import '../models/meal/meal.dart';
import 'meal/meals.dart';

/// Here the category selection will be handled
class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.availableMeals});

  List<Meal> availableMeals;

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
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    var meals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(title: category.title, meals: meals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (var cat in availableCategories)
            CategoryGridItem(
              category: cat,
              onSelectCategory: () => _selectCategory(context, cat),
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
          position:
              Tween(begin: Offset(0, 0.3), end: Offset(0, 0))
                  .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          child: child
      )
    );
  }
}
