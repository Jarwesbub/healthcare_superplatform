import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthcare_superplatform/data/page_constants.dart';
import 'package:healthcare_superplatform/models/human_body_button_model.dart';
import 'package:healthcare_superplatform/widgets/custom_appbar.dart';

class BodyPresentation extends StatefulWidget {
  const BodyPresentation({super.key});

  @override
  State<BodyPresentation> createState() => _BodyPresentationState();
}

class _BodyPresentationState extends State<BodyPresentation> {
  final List<HumanBodyButtonModel> buttons = [
    HumanBodyButtonModel(
      name: 'Eyes',
      info: 'Check information about your eyes',
      offset: Offset(0.48, 0.1),
      icon: Icons.remove_red_eye_rounded,
    ),
    HumanBodyButtonModel(
      name: 'Teeth',
      info: 'Check information about your teeth',
      offset: Offset(0.54, 0.14),
      icon: FontAwesomeIcons.tooth,
    ),
    HumanBodyButtonModel(
      name: 'Heart',
      info: 'Check information about your eyes',
      offset: Offset(0.53, 0.28),
      icon: FontAwesomeIcons.solidHeart,
    ),
    HumanBodyButtonModel(
      name: 'Blood',
      info: 'Check information about your blood',
      offset: Offset(0.82, 0.44),
      icon: FontAwesomeIcons.droplet,
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Center(
            child: Column(
              children: [
                Expanded(flex: 1, child: _upperBar()),
                Expanded(flex: 8, child: bodyPresentation()),
                Expanded(flex: 2, child: _lowerBar(context)),
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
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [bodyPresentation(), Center(child: _lowerBar(context))],
        ),
      ),
    );
  }

  Widget bodyPresentation() {
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
                  (index) => bodyPartButton(
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

  // Button that is drawn to the position based on the given size.
  Widget bodyPartButton(HumanBodyButtonModel button, Size size) {
    final bool isActive = currentButton == button;
    final value = isActive ? 9 : 12;
    final buttonSize = size.width / value;
    //const double buttonSize = 30;

    return Positioned(
      // Calculates padding to the left and top.
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

  Widget _lowerBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
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
                    debugPrint('Clicked Check button');
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

Widget _upperBar() {
  final style = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  return Container(
    padding: const EdgeInsets.all(10),
    constraints: BoxConstraints(maxWidth: 350),
    alignment: Alignment.bottomCenter,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing:',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Clicked Health button');
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFF95F3BC)),
          ),
          child: Text('Health', style: style),
        ),
        ElevatedButton(
          onPressed: () {
            debugPrint('Clicked Injuries button');
          },
          child: Text('Injuries', style: style),
        ),
      ],
    ),
  );
}
