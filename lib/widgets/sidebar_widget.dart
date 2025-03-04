import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key, required this.itemList});
  final Map<String, String> itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color(0xFF3E7455)),
        color: Color(0xFFEEFFF4),
      ),
      child: Column(
        children: List.generate(
          itemList.length,
          (index) => Padding(
            padding: EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                final Uri url = Uri.parse(
                  itemList.entries.toList()[index].value,
                );
                _launchURL(url);
              },
              child: Text(
                itemList.keys.toList()[index],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchURL(Uri url) async {
  // Check if url exists.
  if (!await launchUrl(url)) {
    await launchUrl(url); // Open the url in a browser.
  } else {
    throw ('Could not launch $url');
  }
}
