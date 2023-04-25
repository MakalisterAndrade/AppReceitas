import 'package:flutter/material.dart';

import '../utilities/dummy_data.dart';
import '../utilities/constants.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/recipe_details.dart';
import '../widgets/icon_text.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routePath = '/recipe-details';

  @override
  Widget build(BuildContext context) {
    final _recipeId = ModalRoute.of(context)?.settings.arguments as String;
    final _selectedRecipe =
        DUMMY_RECIPES.firstWhere((recipe) => recipe.id == _recipeId);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    _selectedRecipe.imagePath,
                    height: 250.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 15.0,
                    left: 15.0,
                    child: CustomBackButton(),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 15.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 15.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedRecipe.recipeCategoryTitle,
                      style: kTinyTitleTextStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedRecipe.title,
                          style: kNormalTitleTextStyle,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.black54,
                          ),
                          onTap: () {
                            print('Favorito');
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(
                          icon: Icons.access_time,
                          text: '${_selectedRecipe.duration} minutos',
                        ),
                        IconText(
                          icon:
                              _selectedRecipe.recipeCategoryTitle == 'Bebidas'
                                  ? Icons.local_bar
                                  : Icons.room_service,
                          text: '${_selectedRecipe.servings} porções',
                        ),
                        IconText(
                          icon: Icons.whatshot,
                          text: '${_selectedRecipe.calories} calorias',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      thickness: 0.3,
                      color: Colors.black54,
                    ),
                    RecipeDetails(
                      title: 'Ingredientes',
                      recipeInfo: _selectedRecipe.ingredients,
                    ),
                    RecipeDetails(
                      title: 'Passo a passo',
                      recipeInfo: _selectedRecipe.instructions,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
