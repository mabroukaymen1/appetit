import 'package:flutter/material.dart';
import 'package:flutter_application_2/dar/category.dart';
import 'package:flutter_application_2/dar/chef.dart';
import 'package:flutter_application_2/dar/live.dart';
import 'package:flutter_application_2/dar/rec_card.dart';
import 'package:flutter_application_2/dar/search.dart';
import 'package:flutter_application_2/dar/section.dart';
import 'profile.dart';

class HomeScreen extends StatelessWidget {
  final List<String> recipes = [
    'Sandwich with boiled egg',
    'Simple instant ramen noodle with egg',
    'Delicious minced meat with egg'
  ];

  final List<String> chefs = [
    'Antonio Santana',
    'Miles Antonio',
    'Antonio Jonathan'
  ];

  final Map<String, String> recipeImages = {
    'Sandwich with boiled egg': 'image/sc1.jpg',
    'Simple instant ramen noodle with egg': 'image/sc2.jpg',
    'Delicious minced meat with egg': 'image/sc3.jpg',
  };

  final Map<String, String> chefImages = {
    'Antonio Santana': 'image/sc3.jpg',
    'Miles Antonio': 'image/sc3.jpg',
    'Antonio Jonathan': 'image/sc3.jpg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 16),
                _buildTitle('What do you want to cook today?'),
                SizedBox(height: 16),
                _buildCategoryChips(),
                SizedBox(height: 24),
                _buildSectionHeader('Live cooking', 'view all', () {
                  // Implement view all action
                }),
                SizedBox(height: 16),
                LiveCookingCard(
                  imagePath: 'image/bac.jpeg',
                  chefName: 'Gemaro',
                  dishName: 'Devilled whitebait and calamari',
                ),
                SizedBox(height: 24),
                _buildSectionHeader('Top Chef', 'view all', () {
                  // Implement view all action
                }),
                SizedBox(height: 8),
                _buildChefCards(),
                SizedBox(height: 24),
                _buildSectionHeader('Popular Recipes', 'view all', () {
                  // Implement view all action
                }),
                SizedBox(height: 8),
                _buildRecipeCards(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_recipe');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('image/ppp.jpg'),
          radius: 24,
        ),
        Image.asset(
          'image/appetit.png', // Replace with your logo image path
          height: 40, // Adjust the height as needed
        ),
        IconButton(
          icon: Icon(Icons.search, color: Colors.orange),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(
                  recipes: recipes,
                  chefs: chefs,
                  recipeImages: recipeImages,
                  chefImages: chefImages,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryChip(
            label: 'Soup',
            iconPath: 'image/icons/sop.svg',
          ),
          SizedBox(width: 8),
          CategoryChip(
            label: 'Seafood',
            iconPath: 'image/icons/fru.svg',
          ),
          SizedBox(width: 8),
          CategoryChip(
            label: 'Sushi',
            iconPath: 'image/icons/su.svg',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String action, VoidCallback onPressed) {
    return SectionHeader(
      title: title,
      action: action,
      onPressed: onPressed,
    );
  }

  Widget _buildChefCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chefs.map((chef) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ChefCard(
              name: chef,
              expertise: '${chef.split(" ")[0]} Recipes',
              imagePath: chefImages[chef] ?? 'image/sc3.jpg',
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecipeCards() {
    return Column(
      children: recipes.map((recipe) {
        return Column(
          children: [
            RecipeCard(
              title: recipe,
              imagePath: recipeImages[recipe] ?? 'image/sc1.jpg',
            ),
            SizedBox(height: 16),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    recipes: recipes,
                    chefs: chefs,
                    recipeImages: recipeImages,
                    chefImages: chefImages,
                  ),
                ),
              );
            },
          ),
          SizedBox(width: 40), // Space for the floating action button
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
