import 'package:flutter/material.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barlby Carlsson Montage',
      debugShowCheckedModeBanner: false, // Hide debug banner in the app
      theme: ThemeData(
        colorSchemeSeed: const Color(0xffe86f25),
        iconTheme: const IconThemeData(color: Color(0xffe86f25)),
      ),
      home: const MyHomePage(),
    );
  }
}
