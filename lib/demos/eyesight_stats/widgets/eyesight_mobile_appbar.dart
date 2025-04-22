import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightMobileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EyesightMobileAppBar({
    super.key,
    required this.title,
    required this.isBackButtonVisible,
  });
  final String title;
  final bool isBackButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: EyesightTextStyle().title),
      centerTitle: false,
      backgroundColor: EyesightColors().customPrimary,
      foregroundColor: EyesightColors().surface,

      leading:
          isBackButtonVisible
              // Back button view.
              ? iconButton(Icons.arrow_back, 30, () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              })
              // Normal view.
              : iconButton(FontAwesomeIcons.solidEye, 20, () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }),

      actions: [
        iconButton(FontAwesomeIcons.solidBell, 20, () {
          debugPrint('Pressed bell button');
        }),
      ],
    );
  }

  Widget iconButton(IconData icon, double size, VoidCallback? onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, size: size)),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
