import 'package:flutter/material.dart';
import '../utilities/dummy_data.dart';

import '../models/category.dart';
import '../utilities/constants.dart';
import '../widgets/category_item.dart';
import '../widgets/recipe_item.dart';
import '../screens/category_recipes_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppReceitas'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                          radius: 14.0,
                          backgroundImage: AssetImage('assets/images/pp.jpg'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Olá, Maka',
                          style: kSmallTitleTextStyle,
                        ),
                      ],
                    ),
                    PopupMenuButton<Category>(
                      itemBuilder: (BuildContext context) {
                        return DUMMY_CATEGORIES.map((Category category) {
                          return PopupMenuItem<Category>(
                            value: category,
                            child: Text(category.title),
                          );
                        }).toList();
                      },
                      onSelected: (Category selectedCategory) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryRecipesScreen(),
                            settings: RouteSettings(
                              arguments: {
                                'id': selectedCategory.id,
                                'title': selectedCategory.title,
                              },
                            ),
                          ),
                        );
                      },
                      child: Icon(Icons.menu_open),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Categorias',
                    style: kBigTitleTextStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 25.0,
                    bottom: 30.0,
                  ),
                  height: 100.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: DUMMY_CATEGORIES.map((categoryData) {
                      return CategoryItem(
                        id: categoryData.id,
                        title: categoryData.title,
                        imagePath: categoryData.imagePath,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Receitas mais vistas',
                    style: kBigTitleTextStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                  ),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: DUMMY_RECIPES.map((recipeData) {
                      if (recipeData.id == 'm1' ||
                          recipeData.id == 'm2' ||
                          recipeData.id == 'm3') {
                        return RecipeItem(
                          id: recipeData.id,
                          category: recipeData.recipeCategoryTitle,
                          title: recipeData.title,
                          duration: recipeData.duration,
                          imagePath: recipeData.imagePath,
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
