import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/eyesight_colors.dart';

// Used for the main menu pages in the web view.
// Adds navigation buttons to the lower row.

class EyesightWebAppBar extends StatefulWidget implements PreferredSizeWidget {
  const EyesightWebAppBar({
    super.key,
    required this.buttonTitles,
    required this.onButtonTap,
  });
  final List<String> buttonTitles;
  final void Function(int) onButtonTap;

  @override
  State<EyesightWebAppBar> createState() => _EyesightWebAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _EyesightWebAppBarState extends State<EyesightWebAppBar> {
  final maxWidth = 800; // Max AppBar width.
  late double padding;
  int currentButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    final emptySpace = (MediaQuery.of(context).size.width - maxWidth) / 2;
    padding = emptySpace > 20 ? emptySpace : 20;
    debugPrint('$emptySpace');
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        spacing: 0,
        children: [
          Text(
            'Visi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.5, right: 3),
            child: Icon(FontAwesomeIcons.solidEye, size: 20),
          ),
          Text(
            //widget.title,
            'nary Health',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      titleSpacing: padding,
      bottom: PreferredSize(
        preferredSize: Size(1000, 100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 22,
            children: List.generate(widget.buttonTitles.length, (index) {
              return pageWidget(
                index,
                widget.buttonTitles[index],
                index == currentButtonIndex,
              );
            }),
          ),
        ),
      ),
      centerTitle: false,
      backgroundColor: EyesightColors().customPrimary,
      foregroundColor: EyesightColors().surface,
    );
  }

  Widget iconButton(IconData icon, double size, VoidCallback? onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, size: size)),
    );
  }

  Widget pageWidget(int id, String text, bool isActive) {
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
          widget.onButtonTap(id);
          setState(() {
            currentButtonIndex = id;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: EyesightColors().plain,
            fontSize: 20,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
