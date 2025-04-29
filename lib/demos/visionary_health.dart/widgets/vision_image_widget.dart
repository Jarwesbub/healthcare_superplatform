import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:healthcare_superplatform/demos/visionary_health.dart/models/vision_image_model.dart';

class VisionImageWidget extends StatelessWidget {
  const VisionImageWidget({super.key, required this.model});
  final VisionImageModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: model,
      child: Consumer<VisionImageModel>(
        builder: (context, model, child) {
          return Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: RotatedBox(
                quarterTurns: model.id % 4, // Example rotation logic
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/images/open_circle.svg',
                    colorFilter: ColorFilter.mode(model.color, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
