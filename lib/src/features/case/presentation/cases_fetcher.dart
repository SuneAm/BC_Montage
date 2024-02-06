import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

final _watchMontageCases = StreamProvider<List<Case>>(
    (ref) => ref.watch(caseRepoProvider).watchMontageCases());

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
      asyncValue: ref.watch(_watchMontageCases),
      data: (cases) => ListView.builder(
        padding: const EdgeInsets.all(3),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseItem = cases[index];

          final budget = caseItem.estimatedHours.montageEstimatedHour;
          final hourSpent = caseItem.hourAggregate?.montageHourSpent ?? 0;

          final address = caseItem.deliveryAddress?.address;
          final postalCode = caseItem.deliveryAddress?.postalCode ?? '';
          final city = caseItem.deliveryAddress?.city ?? '';

          final contactPerson = caseItem.contactPerson;
          final contactPersonName = contactPerson?.name ?? '';
          final phoneNumber = contactPerson?.phoneNumber ?? '';

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
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: caseItem.caseNumber,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' - ${caseItem.responsibleUser.fullName}',
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 49, 49, 49),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        caseItem.projectName,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      if (address != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            InkResponse(
                              onTap: () => openInGoogleMap(address),
                              child: const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                  '$address${postalCode.isNotEmpty ? ', $postalCode' : ''} $city'),
                            ),
                          ],
                        ),
                      ],
                      if (contactPerson != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            if (phoneNumber.isNotEmpty)
                              InkResponse(
                                onTap: () => openPhoneApp(phoneNumber),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                              ),
                            const SizedBox(width: 4),
                            if (contactPersonName.isNotEmpty ||
                                phoneNumber.isNotEmpty)
                              Expanded(
                                child: Text(
                                    '$contactPersonName ${phoneNumber.isNotEmpty ? '| (+45) $phoneNumber' : ''}'),
                              ),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forbrugt tid", style: medNumbers),
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

  Future<void> openInGoogleMap(String address) async {
    final url = Uri.parse('https://maps.google.com/?q=$address');
    try {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Failed to open link: $e');
    }
  }

  Future<void> openPhoneApp(String phoneNumber) async {
    final launchUri = Uri(scheme: 'tel', path: '+45$phoneNumber');
    try {
      if (!await launchUrl(launchUri)) {
        throw Exception('Could not launch $launchUri');
      }
    } catch (e) {
      debugPrint('Failed to open link: $e');
    }
  }
}
