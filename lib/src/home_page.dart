import 'package:flutter/material.dart';

import 'features/case/presentation/cases_fetcher.dart';
import 'features/live_date/presentation/top_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 93, 93),
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          color: Color.fromARGB(80, 155, 155, 155),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TopBar(),
            Expanded(child: CasesFetcher()),
          ],
        ),
      ),
    );
  }
}
