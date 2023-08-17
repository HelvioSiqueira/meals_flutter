import 'package:flutter/material.dart';
import 'package:meals/188_dummy_data.dart';
import 'package:meals/models/settings.dart';
import 'package:meals/screens/meal_details_screen.dart';
import 'package:meals/screens/settings_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'package:meals/utils/app_routes.dart';
import 'models/meal.dart';
import 'screens/categories_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData();

  Settings settings = Settings();
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _availableMeal = DUMMY_MEALS.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      routes: {
        AppRoutes.HOME: (_) => TabsScreens(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealsScreen(meals: _availableMeal),
        AppRoutes.MEAL_DETAIL: (_) =>
            MealDetailsScreen(onToggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (_) => SettingsScreen(
              onSettingsChanged: _filterMeals,
              settings: settings,
            )
      },
      theme: theme.copyWith(
          scaffoldBackgroundColor: const Color.fromRGBO(255, 254, 229, 1),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.pink,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.amber,
          ),
          textTheme: theme.textTheme.copyWith(
              bodyMedium: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 14,
                  color: Colors.black),
              titleMedium: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 18,
                  color: Colors.black)),
          drawerTheme: const DrawerThemeData(
              backgroundColor: Color.fromRGBO(255, 254, 229, 1)),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 24,
                  fontWeight: FontWeight.w300)),
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.pink, secondary: Colors.amber)
              .copyWith(background: const Color.fromRGBO(255, 254, 229, 1))),
    );
  }
}
