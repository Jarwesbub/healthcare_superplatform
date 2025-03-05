import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsitesWidget extends StatelessWidget {
  const WebsitesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const websites = {
      'Omakanta': 'https://kanta.fi/',
      'YTHS': 'https://www.yths.fi/',
      'Mehiläinen': 'https://www.mehilainen.fi/',
    };

    return Column(
      children: List.generate(
        websites.length,
        (index) => Padding(
          padding: EdgeInsets.all(10),
          child: TextButton(
            onPressed: () {
              final Uri url = Uri.parse(websites.entries.toList()[index].value);
              _launchURL(url);
            },
            child: Text(
              websites.keys.toList()[index],
              style: TextStyle(fontSize: 18),
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
