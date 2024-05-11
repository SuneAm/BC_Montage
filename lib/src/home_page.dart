import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';
import 'package:ordrestyring_montage/src/features/vacation/presentation/request_vacation_dialog.dart';

import 'features/case/presentation/cases_fetcher.dart';
import 'features/live_date/presentation/top_bar.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobileSize = context.isMobile;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 93, 93),
      floatingActionButton: !isMobileSize
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.openDialog(
                const RequestVacationDialog(),
              ),
            ),
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
