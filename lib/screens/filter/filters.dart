import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/filter/filters_provider.dart';

//import 'package:meal_tracker/screens/tabs.dart';
//import 'package:meal_tracker/widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  FiltersScreen({super.key});

  Widget _buildSwitchFilter(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subTitle,
    Filter filter,
    Map<Filter, bool> activeFilters,
  ) {
    return SwitchListTile(
      value: activeFilters[filter]!,
      onChanged: (newValue) {
        ref.read(filtersProvider.notifier).setFilter(filter, newValue);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeThumbColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Your filters')),
      /*drawer: MainDrawer(
        onSelectScreen: (identifier) {
          Navigator.of(context).pop();
          if (identifier == 'meals') {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => TabsScreen()),
            );
          }
        },
      ),*/
      body: Column(
        children: [
          _buildSwitchFilter(
            context,
            ref,
            'Gluten-free',
            'Only include gluten free meals',
            Filter.glutenFree,
            activeFilters,
          ),
          _buildSwitchFilter(
            context,
            ref,
            'Lactose-free',
            'Only include lactose free meals',
            Filter.lactoseFree,
            activeFilters,
          ),
          _buildSwitchFilter(
            context,
            ref,
            'Vegetarian',
            'Only include vegetarian meals',
            Filter.vegetarian,
            activeFilters,
          ),
          _buildSwitchFilter(
            context,
            ref,
            'Vegan',
            'Only include vegan meals',
            Filter.vegan,
            activeFilters,
          ),
        ],
      ),
    );
  }
}
