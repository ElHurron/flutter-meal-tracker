import 'package:flutter/material.dart';

import '../../models/meal/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {
            onToggleFavorite(meal);
          }, icon: Icon(Icons.star))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover
            ),
            SizedBox(height: 14),
            Text('Ingredients', style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold
            )),
            SizedBox(height: 14),
            for (var ingredient in meal.ingredients)
              Text(ingredient, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
              )),
            SizedBox(height: 24),
            Text('Steps', style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold
            )),
            for (var ingredient in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Text(ingredient,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface
                ),
                  textAlign: TextAlign.center,
        
                ),
              ),
          ],
        ),
      ),
    );
  }
}
