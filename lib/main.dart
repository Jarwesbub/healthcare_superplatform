import 'package:flutter/material.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/pages/eyesight_page_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demola',
      debugShowCheckedModeBanner: false,
      home: EyesightPageManager(),
    );
  }
}
