import 'package:flutter/material.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Barlby Carlsson Montage',
      debugShowCheckedModeBanner: false, // Hide debug banner in the app
      home: MyHomePage(), // The main content of the app
    );
  }
}
