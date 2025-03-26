import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/unused/widgets/websites_widget.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        // Set padding on both sides based on the screen width.
        horizontal: MediaQuery.of(context).size.width / 10,
      ),
      child: WebsitesWidget(),
    );
  }
}
