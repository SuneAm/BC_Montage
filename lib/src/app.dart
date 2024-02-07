import 'package:flutter/material.dart';
import 'package:ordrestyring_montage/src/utils/app_theme.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barlby Carlsson Montage',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MyHomePage(),
    );
  }
}
