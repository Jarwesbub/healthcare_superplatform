import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key, required this.onButtonTap});
  final void Function(int) onButtonTap;

  @override
  State<CustomNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<CustomNavigationBar> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services_sharp),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentPage,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green[700],
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        widget.onButtonTap(index);
        setState(() => _currentPage = index);
      },
    );
  }
}
