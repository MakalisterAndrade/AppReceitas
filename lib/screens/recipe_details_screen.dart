import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:app_receitas/utilities/launch.dart';
import '../utilities/dummy_data.dart';
import '../utilities/constants.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/recipe_details.dart';
import '../widgets/icon_text.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routePath = '/recipe-details';

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedRecipe =
        DUMMY_RECIPES.firstWhere((recipe) => recipe.id == recipeId);

    Future<void> launchYoutube() async {
      final url = selectedRecipe.urlVideo;
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Image.network(
                  selectedRecipe.imagePath,
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
                    selectedRecipe.recipeCategoryTitle,
                    style: kTinyTitleTextStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedRecipe.title,
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
                        text: '${selectedRecipe.duration} minutos',
                      ),
                      IconText(
                        icon: selectedRecipe.recipeCategoryTitle == 'Bebidas'
                            ? Icons.local_bar
                            : Icons.room_service,
                        text: '${selectedRecipe.servings} porções',
                      ),
                      IconText(
                        icon: Icons.whatshot,
                        text: '${selectedRecipe.calories} calorias',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    thickness: 0.3,
                    color: Colors.black54,
                  ),
                  RecipeDetails(
                    title: 'Ingredientes',
                    recipeInfo: selectedRecipe.ingredients,
                  ),
                  RecipeDetails(
                    title: 'Passo a passo',
                    recipeInfo: selectedRecipe.instructions,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                            icon: const Icon(Icons.youtube_searched_for,
                                color: Colors.red),
                            label: const Text(
                                'Clique aqui para videos sobre a receita'),
                            onPressed: () {
                              launchYoutube();
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
