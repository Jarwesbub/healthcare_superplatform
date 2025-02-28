import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 701) {
      // Set the mobile view if the screen width is less than the given value.
      return mobileView(context);
    }
    // Use desktop view by default.
    return desktopView(context);
  }

  Widget mobileView(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.onTertiary,
      actions: [userPopupMenu()],

      leading:
          Navigator.canPop(context) // Check if back button can be used.
              ? IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    // Checks if the current view can be closed.
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back, size: 30),
              )
              : null,
    );
  }

  Widget desktopView(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 24)),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.onTertiary,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '<username>',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            userPopupMenu(),
          ],
        ),
      ],
      leading: null,
    );
  }

  // Popup menu widget for the user specific actions.
  Widget userPopupMenu() {
    void onButtonPress(int buttonIndex) {
      switch (buttonIndex) {
        case 0:
          debugPrint('Clicked Profile');
          break;
        case 1:
          debugPrint('Clicked Settings');
          break;
        case 2:
          debugPrint('Clicked Logout');
          break;
      }
    }

    return PopupMenuButton<int>(
      offset: Offset(0, 52),
      menuPadding: EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      onSelected: (value) => onButtonPress(value),
      itemBuilder:
          (context) => [
            PopupMenuItem<int>(value: 0, child: Text('Profile')),
            PopupMenuItem<int>(value: 1, child: Text('Settings')),
            PopupMenuItem<int>(value: 2, child: Text('Logout')),
          ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
