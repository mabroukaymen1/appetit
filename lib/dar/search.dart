import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<String> recipes;
  final List<String> chefs;
  final Map<String, String> recipeImages;
  final Map<String, String> chefImages;

  SearchScreen({
    required this.recipes,
    required this.chefs,
    required this.recipeImages,
    required this.chefImages,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isRecipeSelected = true;

  void _search() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _searchResults = _isRecipeSelected
          ? widget.recipes
              .where((recipe) => recipe.toLowerCase().contains(query))
              .toList()
          : widget.chefs
              .where((chef) => chef.toLowerCase().contains(query))
              .toList();
    });
  }

  void _toggleCategory(bool isRecipe) {
    setState(() {
      _isRecipeSelected = isRecipe;
      _searchResults = [];
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            _search();
          },
          decoration: InputDecoration(
            hintText: _isRecipeSelected ? 'Search recipes' : 'Search chefs',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.orange.shade100,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryTabs(),
            SizedBox(height: 16),
            _buildFilterButton(),
            SizedBox(height: 32),
            Expanded(child: _buildSearchResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Row(
      children: [
        _buildCategoryTab(
            'Recipes', _isRecipeSelected, () => _toggleCategory(true)),
        _buildCategoryTab(
            'Chefs', !_isRecipeSelected, () => _toggleCategory(false)),
      ],
    );
  }

  Widget _buildCategoryTab(String label, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.brown : Colors.grey,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4.0),
                height: 2.0,
                width: 40.0,
                color: Colors.orange,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          // Handle filter action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: CircleBorder(),
          padding: EdgeInsets.all(16),
        ),
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          'No results found 😣',
          style: TextStyle(
            fontSize: 24,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          String result = _searchResults[index];
          String imagePath = _isRecipeSelected
              ? widget.recipeImages[result] ?? 'image/default.jpg'
              : widget.chefImages[result] ?? 'image/default.jpg';

          return ListTile(
            leading: _isRecipeSelected
                ? Image.asset(imagePath)
                : CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                  ),
            title: Text(result),
          );
        },
      );
    }
  }
}
