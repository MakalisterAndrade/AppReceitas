import 'package:app_receitas/screens/category_recipes_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/dummy_data.dart';

import '../utilities/constants.dart';
import '../widgets/category_item.dart';
import '../widgets/recipe_item.dart';

class HomeScreen extends StatelessWidget {
  static const routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AppReceitas'), actions: [
          PopupMenuButton(
              onSelected: (String value) {},
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(value: 'c1', child: Text('Café da manhã')),
                  PopupMenuItem(value: 'c2', child: Text('Almoço')),
                  PopupMenuItem(value: 'c3', child: Text('Bebidas')),
                  PopupMenuItem(value: 'c4', child: Text('Sopas')),
                  PopupMenuItem(value: 'c5', child: Text('Saladas')),
                ];
              })
        ]),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 0.0,
                top: 25.0,
                bottom: 15.0,
                right: 0.0,
              ),
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
                      ///////////////////////////////////////// FOR TESTING/////////////////////////////////////////////////////////////////////
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
        ));
  }
}
