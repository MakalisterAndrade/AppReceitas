import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/category_recipes_screen.dart';
import 'screens/recipe_details_screen.dart';

void main() {
  runApp(DevicePreview(
      enabled: true,
      builder: (BuildContext context) => MaterialApp(
              useInheritedMediaQuery: true,
              locale: DevicePreview.locale(context),
              builder: (context, child) {
                child = DevicePreview.appBuilder(context, child);
                return child;
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  colorSchemeSeed: Colors.deepOrangeAccent, useMaterial3: true),
              initialRoute: HomeScreen.routePath,
              routes: {
                HomeScreen.routePath: (context) => HomeScreen(),
                CategoryRecipesScreen.routePath: (context) =>
                    CategoryRecipesScreen(),
                RecipeDetailsScreen.routePath: (context) =>
                    RecipeDetailsScreen(),
              })));
}
