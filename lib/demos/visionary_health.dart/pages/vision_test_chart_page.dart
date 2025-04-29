import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisionTestChartPage extends StatefulWidget {
  const VisionTestChartPage({super.key});

  @override
  State<VisionTestChartPage> createState() => _VisionTestChartPageState();
}

class _VisionTestChartPageState extends State<VisionTestChartPage> {
  int? selectedSegment;
  int currentRotation = 0;
  int currentRound = 1;
  double smallCircleSize = 20;
  int currentSlide = 0;
  int leftEyeScore = 0;
  int rightEyeScore = 0;
  bool isRightEye = false;

  void onSegmentPressed(int segment) {
    setState(() {
      if (segment == _getCorrectSegment()) {
        selectedSegment = segment;
        smallCircleSize = max(5, smallCircleSize - 3);
        if (isRightEye) {
          rightEyeScore++;
        } else {
          leftEyeScore++;
        }
      } else {
        selectedSegment = -segment;
      }

      currentRound++;
      currentRotation = (currentRotation + Random().nextInt(8) + 1) % 8;

      if (currentRound > 10) {
        if (!isRightEye) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Vaihe valmis'),
                  content: const Text('Peitä oikea silmäsi ja jatka testiä.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          isRightEye = true;
                          currentRound = 1;
                          smallCircleSize = 50;
                          selectedSegment = null;
                          currentRotation = 0;
                        });
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        } else {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Testi valmis'),
                  content: Text(
                    'Vasen silmäsi sai $leftEyeScore/10 oikein.\n'
                    'Oikea silmäsi sai $rightEyeScore/10 oikein.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          isRightEye = false;
                          leftEyeScore = 0;
                          rightEyeScore = 0;
                          currentRound = 1;
                          smallCircleSize = 50;
                          selectedSegment = null;
                          currentRotation = 0;
                        });
                      },
                      child: const Text('Uudestaan'),
                    ),
                  ],
                ),
          );
        }
      }
    });
  }

  int _getCorrectSegment() {
    return (1 + currentRotation) % 8 == 0 ? 8 : (1 + currentRotation) % 8;
  }

  @override
  Widget build(BuildContext context) {
    if (currentSlide < 2) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (currentSlide == 0)
                Column(
                  children: [
                    Container(
                      width: 220,
                      height: 150,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/images/eye2.svg',
                              width: 80,
                              height: 80,
                            ),
                            SvgPicture.asset(
                              'assets/images/eye.svg',
                              width: 80,
                              height: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Peitä vasen silmäsi.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Valmistaudu testiä varten.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )
              else if (currentSlide == 1)
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/circle1.svg',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 120,
                      height: 150,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                            top: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/circle3.svg',
                            width: 100,
                            height: 100,
                          ),
                          Positioned(
                            top: 10,
                            child: SvgPicture.asset(
                              'assets/images/cursor.svg',
                              width: 30,
                              height: 30,
                            ),
                          ),
                          Positioned(
                            top: 40,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Merkitse piste.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Näetkö ylemmän ympyrän? Merkitse vastaava piste alempaan ympyrään.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentSlide++;
                  });
                },
                child: Text(
                  currentSlide == 0 ? 'Seuraava vaihe' : 'Olen valmis',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Näöntarkkuustesti'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Näöntarkkuus',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Kierros: $currentRound / 10',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '1) Peitä vasen silmäsi.\n'
                '2) Pidä laite käsivarren mitan päässä.\n'
                '3) Näetkö ylemmän ympyrän? Merkitse vastaava aukko alempaan ympyrään.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: smallCircleSize,
              height: smallCircleSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(smallCircleSize / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: currentRotation * (pi / 4),
                child: SvgPicture.asset(
                  'assets/images/circle1.svg',
                  width: smallCircleSize / 2,
                  height: smallCircleSize / 2,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  for (int i = 1; i <= 8; i++)
                    Positioned(
                      left: _getLeftPosition(i),
                      top: _getTopPosition(i),
                      child: GestureDetector(
                        onTap: () => onSegmentPressed(i),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/circle2/$i.png',
                              width: 70,
                              height: 70,
                              color:
                                  selectedSegment == i
                                      ? Colors.green
                                      : selectedSegment == -i
                                      ? Colors.red
                                      : null,
                              colorBlendMode: BlendMode.srcIn,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getLeftPosition(int segment) {
    switch (segment) {
      case 1:
        return 115;
      case 2:
        return 185;
      case 3:
        return 213;
      case 4:
        return 185;
      case 5:
        return 115;
      case 6:
        return 45;
      case 7:
        return 13;
      case 8:
        return 45;
      default:
        return 0;
    }
  }

  double _getTopPosition(int segment) {
    switch (segment) {
      case 1:
        return 35;
      case 2:
        return 60;
      case 3:
        return 130;
      case 4:
        return 200;
      case 5:
        return 225;
      case 6:
        return 200;
      case 7:
        return 130;
      case 8:
        return 60;
      default:
        return 0;
    }
  }
}
