import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodyPresentation extends StatefulWidget {
  const BodyPresentation({super.key});

  @override
  State<BodyPresentation> createState() => _BodyPresentationState();
}

class _BodyPresentationState extends State<BodyPresentation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          children: [
            upperBar(),
            Expanded(flex: 4, child: bodyPresentation()),
            Expanded(flex: 1, child: lowerBar()),
          ],
        ),
      ),
    );
  }

  Widget bodyPresentation() {
    return AspectRatio(
      aspectRatio: 0.5,
      child: Center(
        child: Stack(
          children: [
            SvgPicture.asset('assets/images/body_man.svg', height: 500),
          ],
        ),
      ),
    );
  }

  Widget upperBar() {
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

  Widget lowerBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Blood',
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
            child: const Text(
              'Check your blood information',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          ElevatedButton(
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
