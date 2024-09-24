import 'package:flutter/material.dart';
import 'package:flutter_application_2/dar/home.dart';

import 'package:flutter_application_2/dar/recipe.dart';
import 'package:flutter_application_2/dar/search.dart';
import 'package:flutter_application_2/info.dart';
import 'package:flutter_application_2/open.dart';

void main() {
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: IntroScreen(),
      routes: {
        '/search': (context) => SearchScreen(
              recipes: [],
              chefs: [],
              recipeImages: {},
              chefImages: {},
            ),
        '/add_recipe': (context) => AddRecipeScreen(),
      },
    );
  }
}
