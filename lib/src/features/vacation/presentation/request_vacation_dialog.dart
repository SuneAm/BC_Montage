import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

class RequestVacationDialog extends HookConsumerWidget {
  const RequestVacationDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(usersProvider);
    final selectedProfile = useState<User?>(null);

    final startDate = useState<DateTime?>(null);
    final endDate = useState<DateTime?>(null);
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 450,
          maxHeight: 700,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Request For Vacation'),
              const SizedBox(height: 16),
              DropdownButton<User?>(
                hint: const Text('Select Profile'),
                value: selectedProfile.value,
                isExpanded: true,
                onChanged: (User? user) => selectedProfile.value = user,
                items: users
                    .map(
                      (user) => DropdownMenuItem<User>(
                        value: user,
                        child: Text(user.fullName),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              _DateContainer(
                title: 'Dates',
                backgroundColor: Colors.grey.shade300,
                startDate: startDate.value?.formatDate,
                endDate: endDate.value?.formatDate,
                onStartDate: () async {
                  final selectedDate = await context.selectDate(
                    'Start Date',
                  );
                  if (selectedDate != null) {
                    startDate.value = selectedDate;
                  }
                },
                onEndDate: () async {
                  final selectedDate = await context.selectDate(
                    'End Date',
                  );
                  if (selectedDate != null) endDate.value = selectedDate;
                },
              ),
              const SizedBox(height: 24),
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final profile = selectedProfile.value;
                      final selectedStartDate = startDate.value;
                      final selectedEndDate = endDate.value;

                      if (profile == null ||
                          selectedStartDate == null ||
                          selectedEndDate == null) return;

                      // saving request now
                      final vacation = Vacation(
                        createdAt: DateTime.now(),
                        startDate: selectedStartDate,
                        endDate: selectedEndDate,
                        user: profile,
                      );

                      await ref
                          .read(vacationRepoProvider)
                          .createVacationRequest(vacation);

                      if (context.mounted) {
                        context.showSnackBar('Vacation Request Send');
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Send Request'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateContainer extends StatelessWidget {
  const _DateContainer({
    required this.title,
    required this.backgroundColor,
    this.startDate,
    this.endDate,
    this.onStartDate,
    this.onEndDate,
  });

  final String title;
  final Color backgroundColor;
  final String? startDate;
  final String? endDate;
  final VoidCallback? onStartDate;
  final VoidCallback? onEndDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppContainer(
        borderRadius: Constant.kNoBorderRadius,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(title),
              Row(
                children: [
                  const Expanded(child: Text('Start Date:')),
                  Expanded(
                    flex: 2,
                    child: AppContainer(
                      borderRadius: Constant.kNoBorderRadius,
                      border: Border.all(),
                      padding: const EdgeInsets.all(4),
                      child: Text(startDate ?? ''),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkResponse(
                    onTap: onStartDate,
                    child: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Expanded(child: Text('End Date:')),
                  Expanded(
                    flex: 2,
                    child: AppContainer(
                      borderRadius: Constant.kNoBorderRadius,
                      border: Border.all(),
                      padding: const EdgeInsets.all(4),
                      child: Text(endDate ?? ''),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkResponse(
                    onTap: onEndDate,
                    child: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
