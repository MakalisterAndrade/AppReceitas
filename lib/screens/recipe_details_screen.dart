import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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

    Future<void> launchYoutube(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
            headers: <String, String>{'my_header_key': 'my_header_value'}),
      )) {
      } else {
        throw Exception('Não pode executar o link $url');
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
                            icon: const Icon(FontAwesome.youtube,
                                color: Colors.red),
                            label: const Text(
                                'Clique aqui para videos sobre a receita'),
                            onPressed: () => launchYoutube(
                                'https://www.youtube.com/results?search_query=${selectedRecipe.title}'
                                    as Uri))
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
