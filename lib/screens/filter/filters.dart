import 'package:flutter/material.dart';
//import 'package:meal_tracker/screens/tabs.dart';
//import 'package:meal_tracker/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan
}

class FiltersScreen extends StatefulWidget {
  FiltersScreen({super.key, required this.currentFilters});

  Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarian = widget.currentFilters[Filter.vegetarian]!;
    _vegan = widget.currentFilters[Filter.vegan]!;
  }

  Widget _buildSwitchFilter(BuildContext context,
      String title,
      String subTitle,
      bool currentValue,
      void Function(bool newValue) onSwitch,) {
    return SwitchListTile(
      value: currentValue,
      onChanged: (newValue) {
        setState(() {
          onSwitch(newValue);
        });
      },
      title: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge!
            .copyWith(
          color: Theme
              .of(context)
              .colorScheme
              .onSurface,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme
            .of(context)
            .textTheme
            .labelMedium!
            .copyWith(
          color: Theme
              .of(context)
              .colorScheme
              .onSurface,
        ),
      ),
      activeThumbColor: Theme
          .of(context)
          .colorScheme
          .tertiary,
      contentPadding: EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if(didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarian,
            Filter.vegan: _vegan,
          });
        },
        child: Column(
          children: [
            _buildSwitchFilter(
                context, 'Gluten-free', 'Only include gluten free meals',
                _glutenFreeFilterSet, (newValue) =>
            _glutenFreeFilterSet = newValue),
            _buildSwitchFilter(
                context, 'Lactose-free', 'Only include lactose free meals',
                _lactoseFreeFilterSet, (newValue) =>
            _lactoseFreeFilterSet = newValue),
            _buildSwitchFilter(
                context, 'Vegetarian', 'Only include vegetarian meals',
                _vegetarian, (newValue) =>
            _vegetarian = newValue),
            _buildSwitchFilter(
                context, 'Vegan', 'Only include vegan meals',
                _vegan, (newValue) =>
            _vegan = newValue),
          ],
        ),
      ),
    );
  }
}
