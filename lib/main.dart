import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'http_overrides.dart'; // override
import 'src/app.dart';
import 'src/firebase_options.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}
