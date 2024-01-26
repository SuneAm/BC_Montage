import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ordrestyring_display/src/common_widgets/async_widgets/common_async_widget.dart';
import 'package:ordrestyring_display/src/features/case/domain/case.dart';
import 'package:ordrestyring_display/src/features/case/domain/hour_aggregate.dart';
import 'package:ordrestyring_display/src/features/case/presentation/case_controller.dart';

class CasesFetcher extends ConsumerWidget {
  const CasesFetcher({super.key});

  TextStyle get medNumbers => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 49, 49, 49),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonAsyncWidget(
      asyncValue: ref.watch(watchCasesProvider),
      data: (cases) => ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseItem = cases[index];

          final budget = caseItem.productionEstimatedHour;
          final hourSpent = caseItem.hourAggregate?.productionHourSpent ?? 0;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  caseItem.caseNumber,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 49, 49, 49),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        caseItem.projectName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          'Projektleder: ${caseItem.responsibleUser.fullName}'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Timer Forbrugt", style: medNumbers),
                    const SizedBox(height: 6),
                    // SizedBox(
                    //   width: 400,
                    //   child: VerticalBarChart(
                    //     estimatedTime: timer.timer.toDouble(), // Estimated time
                    //     consumedTime: caseItem.economy.billableHoursCount, // Consumed time
                    //     containerWidth: 250.0,
                    //   ),
                    // ),
                    ProgressBar(
                      width: 250,
                      limit: budget,
                      used: hourSpent,
                      showUsed: hourSpent,
                      // from sunes fix
                      height: 44,
                    )
                  ],
                ),
                //const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Budget", style: medNumbers),
                    const SizedBox(height: 6),
                    Text(
                      budget.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  final double width;
  final double limit;
  final double used;
  final double height;
  final double showUsed;

  const ProgressBar({
    super.key,
    required this.width,
    required this.limit,
    required this.used,
    required this.showUsed,
    this.height = 20,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (used > limit) ? 1.0 : used / limit;
    final barColor = (used > limit) ? Colors.red : Colors.green;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 197, 197, 197),
        border: Border.all(),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage.clamp(0.0, 1.0),
              // Ensuring the value is between 0 and 1
              child: Container(
                decoration: BoxDecoration(
                  color: barColor,
                  //borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              showUsed.toStringAsFixed(0),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on Case {
  double get productionEstimatedHour =>
      estimatedHours?.estimatedProductionHour ?? 0;
}

extension on HourAggregate {
  double get productionHourSpent {
    final calculationTypes = CalculationHourTypes.values.where(
        (element) => element.calculationTypes == CalculationTypes.Produktion);
    final filteredList = hourTypes
        .where((hour) =>
            calculationTypes.any((type) => hour.name.contains(type.name)))
        .toList();

    return filteredList.fold(
        0.0,
        (previousValue, element) =>
            (element.totalWorkHours ?? 0.0) + previousValue);
  }
}

enum CalculationTypes { Produktion }

enum CalculationHourTypes {
  productionProjectManager.production('Produktion Projektleder'),
  productionJoiner.production('Produktion Snedker'),
  VrkfrertidpOrdre.production('Værkførertid på Ordre'),
  ;

  const CalculationHourTypes.production(this.name)
      : calculationTypes = CalculationTypes.Produktion;

  final String name;
  final CalculationTypes calculationTypes;
}
