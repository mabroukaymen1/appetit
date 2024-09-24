import 'package:flutter/material.dart';
import 'search.dart';
import 'profile.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/search');
        break;
      case 2:
        // Handle notifications tap
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          NavBarItem(
            icon: Icons.home,
            label: 'Home',
            index: 0,
            isSelected: _selectedIndex == 0,
            onTap: _onItemTapped,
          ),
          NavBarItem(
            icon: Icons.search,
            label: 'Search',
            index: 1,
            isSelected: _selectedIndex == 1,
            onTap: _onItemTapped,
          ),
          SizedBox(width: 40), // Space for the floating action button
          NavBarItem(
            icon: Icons.notifications_none,
            label: 'Notifications',
            index: 2,
            isSelected: _selectedIndex == 2,
            onTap: _onItemTapped,
          ),
          NavBarItem(
            icon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            isSelected: _selectedIndex == 3,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;
  final Function(int) onTap;

  const NavBarItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Colors.orange : Colors.grey,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.orange : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
