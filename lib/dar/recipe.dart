import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  int currentStep = 0;
  final int totalSteps = 5;

  final titleController = TextEditingController();
  final List<TextEditingController> ingredientControllers = [];
  final List<TextEditingController> directionControllers = [];
  final List<TextEditingController> quantityControllers = [];
  final List<String> units = [];
  final List<String> unitOptions = ['g', 'kg', 'oz', 'lb'];

  File? _recipeImage;
  File? _video;
  final List<File> _galleryImages = [];

  @override
  void dispose() {
    titleController.dispose();
    ingredientControllers.forEach((controller) => controller.dispose());
    directionControllers.forEach((controller) => controller.dispose());
    quantityControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildCurrentStep(),
                ),
              ),
            ),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
          Text(
            'Add Recipe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildStepIndicator(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFF6750A4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${currentStep + 1}/$totalSteps',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return TitleStep(
          controller: titleController,
          onImagePicked: (image) {
            setState(() {
              _recipeImage = image;
            });
          },
          image: _recipeImage,
        );
      case 1:
        return InformationStep();
      case 2:
        return IngredientsStep(
          ingredientControllers: ingredientControllers,
          quantityControllers: quantityControllers,
          units: units,
          unitOptions: unitOptions,
          onAddIngredient: () {
            setState(() {
              ingredientControllers.add(TextEditingController());
              quantityControllers.add(TextEditingController());
              units.add(unitOptions[0]);
            });
          },
        );
      case 3:
        return DirectionsStep(
          controllers: directionControllers,
          onAddDirection: () {
            setState(() {
              directionControllers.add(TextEditingController());
            });
          },
        );
      case 4:
        return OptionalStep(
          onVideoPicked: (video) {
            setState(() {
              _video = video;
            });
          },
          video: _video,
          onImagePicked: (image) {
            setState(() {
              _galleryImages.add(image);
            });
          },
          galleryImages: _galleryImages,
        );
      default:
        return Container();
    }
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentStep -= 1;
                  });
                },
                child: Text('Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFF8FA),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
          if (currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (currentStep < totalSteps - 1) {
                  setState(() {
                    currentStep += 1;
                  });
                } else {
                  _saveRecipe();
                }
              },
              child: Text(currentStep == totalSteps - 1 ? 'Save' : 'Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF8C42),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveRecipe() {
    // Save recipe logic here
    // For now, just print the recipe details
    print('Title: ${titleController.text}');
    print('Ingredients: ${ingredientControllers.map((c) => c.text).toList()}');
    print('Quantities: ${quantityControllers.map((c) => c.text).toList()}');
    print('Units: $units');
    print('Directions: ${directionControllers.map((c) => c.text).toList()}');
    print('Recipe Image: ${_recipeImage?.path}');
    print('Video: ${_video?.path}');
    print('Gallery Images: ${_galleryImages.map((f) => f.path).toList()}');
  }
}

class TitleStep extends StatelessWidget {
  final TextEditingController controller;
  final Function(File) onImagePicked;
  final File? image;

  TitleStep({
    required this.controller,
    required this.onImagePicked,
    this.image,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepContent(
      title: 'Title',
      children: [
        _buildTextField('Title', controller),
        SizedBox(height: 20),
        GestureDetector(
          onTap: _pickImage,
          child: _buildImageContainer(),
        ),
      ],
    );
  }

  Widget _buildImageContainer() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFF8FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: image == null
          ? Icon(Icons.camera_alt, size: 40, color: Colors.black)
          : Image.file(image!, fit: BoxFit.cover),
    );
  }

  Widget _buildStepContent(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFF8FA),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class InformationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildStepContent(
      title: 'Information',
      children: [
        _buildTextField('Time Required', TextEditingController()),
        SizedBox(height: 20),
        _buildTextField('Serving Size', TextEditingController()),
      ],
    );
  }

  Widget _buildStepContent(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFF8FA),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class IngredientsStep extends StatelessWidget {
  final List<TextEditingController> ingredientControllers;
  final List<TextEditingController> quantityControllers;
  final List<String> units;
  final List<String> unitOptions;
  final VoidCallback onAddIngredient;

  IngredientsStep({
    required this.ingredientControllers,
    required this.quantityControllers,
    required this.units,
    required this.unitOptions,
    required this.onAddIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return _buildStepContent(
      title: 'Ingredients',
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: ingredientControllers.length,
          itemBuilder: (context, index) {
            return _buildIngredientRow(index);
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onAddIngredient,
          child: Text('Add Ingredient'),
        ),
      ],
    );
  }

  Widget _buildIngredientRow(int index) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField('Ingredient', ingredientControllers[index]),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildTextField('Quantity', quantityControllers[index]),
        ),
        SizedBox(width: 10),
        DropdownButton<String>(
          value: units[index],
          onChanged: (value) {
            units[index] = value!;
          },
          items: unitOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStepContent(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFF8FA),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class DirectionsStep extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAddDirection;

  DirectionsStep({
    required this.controllers,
    required this.onAddDirection,
  });

  @override
  Widget build(BuildContext context) {
    return _buildStepContent(
      title: 'Directions',
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: controllers.length,
          itemBuilder: (context, index) {
            return _buildTextField(
                'Direction ${index + 1}', controllers[index]);
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onAddDirection,
          child: Text('Add Direction'),
        ),
      ],
    );
  }

  Widget _buildStepContent(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFF8FA),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class OptionalStep extends StatelessWidget {
  final Function(File) onVideoPicked;
  final File? video;
  final Function(File) onImagePicked;
  final List<File> galleryImages;

  OptionalStep({
    required this.onVideoPicked,
    required this.video,
    required this.onImagePicked,
    required this.galleryImages,
  });

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      onVideoPicked(File(pickedFile.path));
    }
  }

  Future<void> _pickGalleryImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepContent(
      title: 'Optional',
      children: [
        ElevatedButton(
          onPressed: _pickVideo,
          child: Text('Upload Video'),
        ),
        if (video != null)
          Container(
            height: 200,
            width: double.infinity,
            child: Text('Video selected'),
          ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickGalleryImage,
          child: Text('Upload Gallery Images'),
        ),
        SizedBox(height: 20),
        if (galleryImages.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: galleryImages.map((image) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(image),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildStepContent(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ...children,
      ],
    );
  }
}

// Helper functions

Widget _buildStepContent(
    {required String title, required List<Widget> children}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      ...children,
    ],
  );
}

Widget _buildTextField(String labelText, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      fillColor: Color(0xFFFFF8FA),
      filled: true,
    ),
  );
}

Widget _buildDropdown(List<String> items) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8FA),
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: items[0],
        isExpanded: true,
        onChanged: (String? newValue) {},
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
  );
}

Widget _buildAddButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text('+ $text'),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFFFF8FA),
      foregroundColor: Color(0xFFFFAC7D),
    ),
  );
}

Widget _buildPlaceholderContent(String mainText, String subText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.upload_outlined, size: 48, color: Colors.grey),
      SizedBox(height: 8),
      Text(mainText, style: TextStyle(color: Colors.grey)),
      Text(subText, style: TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );
}
