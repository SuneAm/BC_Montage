import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart'
    show
        DefaultFirebaseOptions,
        Firebase,
        MyHttpOverrides,
        ProviderScope,
        TimeZoneHelper;

import 'src/app.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  TimeZoneHelper.initializeTimeZone();
  TimeZoneHelper.setLocalLocation();

  runApp(const ProviderScope(child: MyApp()));
}
