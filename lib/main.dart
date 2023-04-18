import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/routes/app_routes.dart';
import 'package:meals/routes/custom_routes.dart';
import 'package:meals/screens/categories_meal/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail/meal_detail_screen.dart';
import 'package:meals/screens/home/tabs_screen.dart';
import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 205, 205, 1),
          fontFamily: "Raleway",
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomPageTransitionsBuilder(),
            TargetPlatform.iOS: CustomPageTransitionsBuilder(),
          })),
      routes: {
        AppRoutes.HOME: (_) => TabsScreen(_favoriteMeals, 0),
        AppRoutes.CATEGORIES_MEALS: (_) =>
            CategoriesMealsScreen(_availableMeals),
        AppRoutes.MEAL_DETAIL: (_) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.MEAL_FAVORITE: (_) => TabsScreen(_favoriteMeals, 1),
      },
    );
  }
}
