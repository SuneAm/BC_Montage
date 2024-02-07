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
      // themeMode: ThemeMode.dark,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(),
    );
  }
}
