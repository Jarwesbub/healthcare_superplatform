import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final bool showBackButton = Navigator.canPop(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Theme.of(context).colorScheme.onTertiary,
      actions: [
        IconButton(
          onPressed: () {
            debugPrint('Pressed profile button');
          },
          icon: const Icon(Icons.toc_outlined, size: 40),
        ),
      ],

      leading:
          showBackButton
              ? IconButton(
                // Back button.
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_left),
              )
              : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
