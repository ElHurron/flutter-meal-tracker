import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_tracker/providers/meal/favorites_provider.dart';

import '../../models/meal/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white)),
        actions: [
          IconButton(onPressed: () {
            var added = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoriteStatus(meal);

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(
                added ? 'Added meal ${meal.title} as favorite'
                    : 'Removed meal ${meal.title} from favorites'
            )));
          },
          icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                    turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
                    child: child
                );
              },
              child: Icon(isFavorite ? (Icons.star) : Icons.star_border, key: ValueKey(isFavorite)))
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                  meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover
              ),
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
