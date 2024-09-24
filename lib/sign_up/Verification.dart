import 'package:flutter/material.dart';
import 'package:flutter_application_2/sign_up/verif-code.dart';

class VerificationMethodScreen extends StatefulWidget {
  @override
  _VerificationMethodScreenState createState() =>
      _VerificationMethodScreenState();
}

class _VerificationMethodScreenState extends State<VerificationMethodScreen> {
  String? _selectedMethod;

  void _selectMethod(String method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF5ED), // Set the background color here
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Color(0xFF333333), size: 20),
                onPressed: () {
                  // Handle back action
                },
              ),
              SizedBox(height: 32),
              Text(
                'Verification\nMethod',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                  height: 1.2,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Choose your preferred method for account verification.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildOptionCard(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    subtitle: 'amanda.samantha@gmail.com',
                    selected: _selectedMethod == 'Email',
                    onTap: () => _selectMethod('Email'),
                  ),
                  _buildOptionCard(
                    icon: Icons.phone_android,
                    title: 'Phone',
                    subtitle: '+62 9999 - 9991 - 432',
                    selected: _selectedMethod == 'Phone',
                    onTap: () => _selectMethod('Phone'),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _selectedMethod != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneVerificationScreen()),
                        ); // Handle next action
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9F5A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 56),
                  elevation: 0,
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 160,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? Color(0xFF5D3EBE) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: selected ? Colors.transparent : Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: selected
                  ? Color(0xFF5D3EBE).withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withOpacity(0.2)
                    : Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: selected ? Colors.white : Color(0xFFFF9F5A),
                size: 24,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: selected ? Colors.white : Color(0xFF333333),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: selected
                    ? Colors.white.withOpacity(0.8)
                    : Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
