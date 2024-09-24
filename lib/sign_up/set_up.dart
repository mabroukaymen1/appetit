import 'package:flutter/material.dart';
import 'package:flutter_application_2/sign_up/final_step.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AccountSetupScreen extends StatefulWidget {
  @override
  _AccountSetupScreenState createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  File? _image;
  final _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF5ED),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                _buildTitle(),
                _buildProfilePicture(),
                _buildUploadText(),
                _buildUsernameField(),
                SizedBox(height: 40),
                _buildContinueButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        'Account\nSetup',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Center(
        child: GestureDetector(
          onTap: _getImage,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: _image != null
                ? ClipOval(
                    child: Image.file(_image!, fit: BoxFit.cover),
                  )
                : Icon(Icons.camera_alt, size: 40, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadText() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Text(
          'Upload your profile picture\n*maximum size 2MB',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFF9F5A)),
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0, top: 40.0),
      child: ElevatedButton(
        onPressed: () {
          // Implement your continu
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetupCompletedScreen(),
            ),
          );
          //e logic here
          print('Username: ${_usernameController.text}');
        },
        child: Text(
          'Continue',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF9F5A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          minimumSize: Size(double.infinity, 56),
        ),
      ),
    );
  }
}
