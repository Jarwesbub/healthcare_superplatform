import 'package:flutter/material.dart';

class EyesightNavigationBar extends StatefulWidget {
  const EyesightNavigationBar({super.key, required this.onButtonTap});
  final void Function(int) onButtonTap;

  @override
  State<EyesightNavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<EyesightNavigationBar> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services_sharp),
          label: 'Services',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.device_hub), label: 'Devices'),
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
