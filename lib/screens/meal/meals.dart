import 'package:flutter/material.dart';
import 'package:meal_tracker/models/meal/meal.dart';
import 'package:meal_tracker/screens/meal/meal_details.dart';
import 'package:meal_tracker/widgets/meal/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('No meals here!',
            style: Theme
                .of(context)
                .textTheme
                .headlineLarge!
                .copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface)
        ),
        Text('Try selecting a different category',
            style: Theme
                .of(context)
                .textTheme
                .bodyLarge!
                .copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSurface)
        )
      ],
    ));

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) =>
              MealItem(
                meal: meals[index],
                onMealSelected: (meal) => _selectMeal(context, meal))
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: content,
    );
  }

}