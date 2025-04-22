import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';

class EyesightWebAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EyesightWebAppBar({
    super.key,
    required this.title,
    required this.pageIndex,
    required this.pages,
    required this.isBackButtonVisible,
  });
  final String title;
  final Map<String, Function?> pages;
  final int pageIndex;
  final bool isBackButtonVisible;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title, style: EyesightTextStyle().title),
      bottom: PreferredSize(
        preferredSize: Size(500, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: List.generate(pages.length, (index) {
              return pageWidget(
                pages.keys.toList()[index],
                pages.values.toList()[index],
                index == 0,
              );
            }),
          ),
        ),
      ),
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
    );
  }

  Widget iconButton(IconData icon, double size, VoidCallback? onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, size: size)),
    );
  }

  Widget pageWidget(String text, Function? onTap, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        border:
            isActive
                ? Border(
                  bottom: BorderSide(width: 1.0, color: EyesightColors().plain),
                )
                : null,
      ),
      child: InkWell(
        onTap: () {
          debugPrint('Button tap');
          onTap;
        },
        child: Text(
          text,
          style: TextStyle(color: EyesightColors().plain, fontSize: 18),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
