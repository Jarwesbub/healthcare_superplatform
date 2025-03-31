import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';

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
          icon: Icon(FontAwesomeIcons.chartLine),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.facebookMessenger),
          label: 'Messages',
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
