import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';

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
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(FontAwesomeIcons.clipboardList),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.facebookMessenger),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentPage,
      backgroundColor: Colors.white,
      selectedItemColor: EyesightColors().customPrimary,
      unselectedItemColor: EyesightColors().customSecondary,

      onTap: (index) {
        widget.onButtonTap(index);
        setState(() => _currentPage = index);
      },
    );
  }
}
