import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_text_style.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/vision_image_model.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/eyesight_mobile_appbar.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/widgets/vision_image_widget.dart';

class VisionTestChartPage extends StatefulWidget {
  const VisionTestChartPage({super.key});

  @override
  State<VisionTestChartPage> createState() => _VisionTestChartState();
}

class _VisionTestChartState extends State<VisionTestChartPage> {
  List<Widget> imageWidgets = [];
  List<VisionImageModel> imageModels = [];
  int imageIndex = 0;
  int? activeImageId;
  String currentEye = 'left';

  @override
  void initState() {
    super.initState();
    imageIndex = 0;
    imageWidgets = List.generate(7, (index) {
      index += 2;
      return imageRow(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    imageIndex = 0;
    return Scaffold(
      appBar: EyesightMobileAppBar(
        title: 'Quick test',
        isBackButtonVisible: true,
      ),
      backgroundColor: EyesightColors().surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                Column(children: imageWidgets),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child:
                      activeImageId == null
                          ? startButton()
                          : instructionsText(),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageRow(int columnIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(columnIndex, (index) {
        final model = VisionImageModel(id: imageIndex);
        imageModels.add(model);
        imageIndex++;

        return VisionImageWidget(model: model);
      }),
    );
  }

  Widget startButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 60, minHeight: 40, minWidth: 100),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: EyesightColors().customPrimary,
        child: InkWell(
          onTap: () {
            setTimer();
          },
          child: Center(
            child: Text(
              'Start test',
              textAlign: TextAlign.center,
              style: EyesightTextStyle().title,
            ),
          ),
        ),
      ),
    );
  }

  Widget instructionsText() {
    return Center(
      child: Text(
        'Close your $currentEye eye',
        textAlign: TextAlign.center,
        style: TextStyle(color: EyesightColors().onSurface, fontSize: 24),
      ),
    );
  }

  void setTimer() {
    _chooseRandomImage();
    currentEye = 'left';
    int maxCount = 10;
    int counter = maxCount;
    debugPrint('Timer started');
    Timer.periodic(const Duration(seconds: 3), (timer) {
      counter--;
      try {
        debugPrint('Timer counter: $counter');
        switch (counter) {
          case 0: // Timer ends.
            debugPrint('Timer ended');
            _clearImage(reset: true);
            timer.cancel();
            break;
          case 5: // Change eye.
            currentEye = 'right';
            _clearImage(reset: false);
            break;
          case _:
            _chooseRandomImage();
            break;
        }
      } catch (error) {
        debugPrint('Error: Page was closed -> cancel timer.');
        timer.cancel();
      }
    });
  }

  void _chooseRandomImage() {
    setState(() {
      if (activeImageId != null) {
        imageModels[activeImageId!].color = Colors.grey;
      }
      debugPrint('ActiveImageId: $activeImageId');
      activeImageId = Random().nextInt(imageModels.length);
      imageModels[activeImageId!].color = Colors.black;
    });
  }

  void _clearImage({required bool reset}) {
    setState(() {
      imageModels[activeImageId!].color = Colors.grey;
      if (reset) activeImageId = null;
    });
  }
}
