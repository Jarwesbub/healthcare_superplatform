import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/unused/models/human_body_button_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_stats_page.dart';
import 'package:healthcare_superplatform/unused/widgets/custom_appbar.dart';

class BodyPresentation extends StatefulWidget {
  const BodyPresentation({super.key});

  @override
  State<BodyPresentation> createState() => _BodyPresentationState();
}

class _BodyPresentationState extends State<BodyPresentation> {
  // List of data for button widgets.
  final List<HumanBodyButtonModel> buttons = [
    HumanBodyButtonModel(
      name: 'Eyes',
      info: 'Check information about your eyes',
      offset: Offset(0.48, 0.1),
      icon: Icons.remove_red_eye_rounded,
      page: EyesightStatsPage(),
    ),
    HumanBodyButtonModel(
      name: 'Teeth',
      info: 'Check information about your teeth',
      offset: Offset(0.54, 0.14),
      icon: FontAwesomeIcons.tooth,
      page: null,
    ),
    HumanBodyButtonModel(
      name: 'Heart',
      info: 'Check information about your heart',
      offset: Offset(0.53, 0.28),
      icon: FontAwesomeIcons.solidHeart,
      page: null,
    ),
    HumanBodyButtonModel(
      name: 'Blood',
      info: 'Check information about your blood',
      offset: Offset(0.82, 0.44),
      icon: FontAwesomeIcons.droplet,
      page: null,
    ),
  ];
  HumanBodyButtonModel? currentButton;
  late bool isMobileView;

  @override
  Widget build(BuildContext context) {
    isMobileView =
        MediaQuery.of(context).size.width < PageConstants.mobileViewLimit;

    if (isMobileView) {
      return Scaffold(
        appBar: CustomAppBar(title: 'Your body information'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              children: [
                Expanded(flex: 8, child: bodyPresentationView()),
                Expanded(flex: 2, child: _lowerBar()),
              ],
            ),
          ),
        ),
      );
    }
    // Desktop view.
    return Scaffold(
      appBar: CustomAppBar(title: 'Your body information'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [bodyPresentationView(), Center(child: _lowerBar())],
        ),
      ),
    );
  }

  // Shows human body image and generates buttons based on the offset value.
  Widget bodyPresentationView() {
    return AspectRatio(
      aspectRatio: 0.5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          debugPrint('Constraints: $constraints');
          return Center(
            child: Stack(
              children: [
                SvgPicture.asset('assets/images/body_man.svg'),
                ...List.generate(
                  buttons.length,
                  (index) => _bodyPartButton(
                    buttons[index],
                    Size(constraints.maxWidth, constraints.maxHeight),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Button that is drawn to the position based on the given widget size.
  // Offset is a value between 0.0 to 1.0 that is based on the widget size.
  Widget _bodyPartButton(HumanBodyButtonModel button, Size size) {
    final bool isActive = currentButton == button;
    final value = isActive ? 9 : 12;
    final buttonSize = size.width / value;

    return Positioned(
      // Calculates padding to the left and top.
      // Position x = width * (decimal value between 0 to 1) - (button radius).
      left: size.width * button.offset.dx - (buttonSize / 2),
      top: size.height * button.offset.dy - (buttonSize / 2),
      child: InkWell(
        customBorder: CircleBorder(),
        splashColor: Colors.blue,
        onTap: () {
          setState(() {
            currentButton = button;
          });
        },
        child: Container(
          height: buttonSize,
          width: buttonSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.green : Colors.redAccent,
          ),
          child:
              isActive
                  ? Icon(
                    button.icon,
                    color: Colors.white,
                    size: buttonSize - (buttonSize / 4),
                  )
                  : const SizedBox(),
        ),
      ),
    );
  }

  // Informs what button is currently active.
  // "Check button" can be used as an interface for the body stats.
  Widget _lowerBar() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      constraints: BoxConstraints(
        maxWidth: 500,
        maxHeight: 200,
        minHeight: 100,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              currentButton == null ? '' : currentButton!.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              currentButton == null ? '' : currentButton!.info,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          currentButton == null
              ? const SizedBox()
              : Flexible(
                flex: 1,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    if (currentButton?.page != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => currentButton!.page!,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Check',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
