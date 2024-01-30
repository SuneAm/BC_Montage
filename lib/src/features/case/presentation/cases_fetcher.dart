import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

class CasesFetcher extends ConsumerWidget {
  const CasesFetcher({super.key});

  TextStyle get medNumbers => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 49, 49, 49),
      );
  TextStyle get hourSpent => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 49, 49, 49),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonAsyncWidget(
      asyncValue: ref.watch(watchCasesProvider),
      data: (cases) => ListView.builder(
        padding: const EdgeInsets.all(3),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseItem = cases[index];

          final budget = caseItem.estimatedHours.montageEstimatedHour;
          final hourSpent = caseItem.hourAggregate?.montageHourSpent ?? 0;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            caseItem.caseNumber,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '- ${caseItem.responsibleUser.fullName}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 49, 49, 49),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        caseItem.projectName,
                        style: const TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Timer Forbrugt", style: medNumbers),
                    const SizedBox(height: 2),
                    ProgressBar(
                      width: 100,
                      limit: budget,
                      used: hourSpent,
                      showUsed: hourSpent,
                      // from sunes fix
                      height: 20,
                      usedFontSize: 14,
                    )
                  ],
                ),
                //const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Budget", style: medNumbers),
                    const SizedBox(height: 2),
                    Text(
                      budget.toStringAsFixed(0),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
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
