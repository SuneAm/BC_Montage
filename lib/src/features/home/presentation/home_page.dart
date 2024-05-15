import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';
import 'package:ordrestyring_montage/src/features/production/presentation/production_view.dart';
import 'package:ordrestyring_montage/src/features/vacation/presentation/vacation_view.dart';
import 'package:ordrestyring_montage/src/utils/assets_util.dart';

import '../../case/presentation/cases_fetcher.dart';
import '../../live_date/presentation/top_bar.dart';

part 'home_controller.dart';

part 'root_view.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopBar(),
            Expanded(
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  final homeView = ref.watch(homeViewProvider);

                  return switch (homeView) {
                    HomeView.root => const _HomeRootView(),
                    HomeView.montage => const CasesFetcher(),
                    HomeView.production => const ProductionView(),
                    HomeView.vacation => const VacationView(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
