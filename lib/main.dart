import 'dart:io';

import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:ordrestyring_common/ordrestyring_common.dart'
    show DefaultFirebaseOptions, Firebase, ProviderScope, MyHttpOverrides;

import 'src/app.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}
