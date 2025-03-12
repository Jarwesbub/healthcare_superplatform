import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcare_superplatform/models/human_body_button_model.dart';

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
      offset: Offset(0.5, 0.1),
    ),
    HumanBodyButtonModel(
      name: 'Mouth',
      info: 'Check information about your mouth',
      offset: Offset(0.54, 0.14),
    ),
    HumanBodyButtonModel(
      name: 'Heart',
      info: 'Check information about your eyes',
      offset: Offset(0.53, 0.28),
    ),
    HumanBodyButtonModel(
      name: 'Blood',
      info: 'Check information about your blood',
      offset: Offset(0.82, 0.44),
    ),
  ];
  HumanBodyButtonModel? currentButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Center(
          child: Column(
            children: [
              _upperBar(),
              Expanded(flex: 4, child: bodyPresentation()),
              Expanded(flex: 1, child: _lowerBar()),
            ],
          ),
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
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1),
            ),
            child: Center(
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
            ),
          );
        },
      ),
    );
  }

  // Button that is drawn to the position based on the given size.
  Widget bodyPartButton(HumanBodyButtonModel button, Size size) {
    final bool isActive = currentButton == button;
    final value = isActive ? 10 : 14;
    final buttonSize = size.width / value;
    //const double buttonSize = 30;

    return Positioned(
      // Calculates padding to the left and top.
      left: size.width * button.offset.dx - (buttonSize / 2),
      top: size.height * button.offset.dy - (buttonSize / 2),
      child: InkWell(
        customBorder: CircleBorder(),
        splashColor: Colors.green,
        onTap: () {
          setState(() {
            currentButton = button;
          });
        },
        child: Container(
          height: buttonSize,
          width: buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: isActive ? Colors.green : Colors.transparent,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(buttonSize / 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.green : Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _lowerBar() {
    return Container(
      constraints: BoxConstraints(maxWidth: 500),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
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
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
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
              : ElevatedButton(
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
