import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;

  SectionHeader(
      {required this.title,
      required this.action,
      required VoidCallback onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle action tap
          },
          child: Text(
            action,
            style: TextStyle(
              fontSize: 16,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
