import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final bool showBackButton = Navigator.canPop(context);
    if (MediaQuery.of(context).size.width < 701) {
      // User mobile view.
      return mobileView(context, showBackButton);
    }
    return desktopView(context);
  }

  Widget mobileView(BuildContext context, showBackButton) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.onTertiary,
      actions: [
        IconButton(
          // User profile button.
          onPressed: () {
            debugPrint('Pressed profile button (mobile)');
          },
          icon: const Icon(Icons.toc_outlined, size: 40),
        ),
      ],

      leading:
          showBackButton
              ? IconButton(
                // Back button.
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextButton(
            // User profile button.
            onPressed: () {
              debugPrint('Pressed profile button (desktop)');
            },
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ],
      leading: null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
