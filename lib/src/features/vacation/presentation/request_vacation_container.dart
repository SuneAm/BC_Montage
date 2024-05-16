import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

class RequestVacationContainer extends HookConsumerWidget {
  const RequestVacationContainer({
    required this.user,
    this.vacation,
    super.key,
  });

  final User? user;
  final Vacation? vacation;

  bool get isPreviewing => vacation != null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = useState<DateTime?>(vacation?.startDate);
    final endDate = useState<DateTime?>(vacation?.endDate);

    return ConstrainedBox(
      key: key,
      constraints: const BoxConstraints(
        maxWidth: 600,
        maxHeight: 700,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DateContainer(
              title: 'Dates',
              vacationId: vacation?.id,
              backgroundColor: isPreviewing
                  ? Colors.greenAccent.shade100
                  : Colors.grey.shade300,
              startDate: startDate.value?.formatDate,
              endDate: endDate.value?.formatDate,
              onStartDate: isPreviewing
                  ? null
                  : () async {
                      final selectedDate = await context.selectDate(
                        'Start Date',
                      );
                      if (selectedDate != null) {
                        startDate.value = selectedDate;
                      }
                    },
              onEndDate: isPreviewing
                  ? null
                  : () async {
                      final selectedDate = await context.selectDate(
                        'End Date',
                      );
                      if (selectedDate != null) endDate.value = selectedDate;
                    },
            ),
            if (!isPreviewing) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    final profile = user;
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
                      startDate.value = null;
                      endDate.value = null;
                    }
                  },
                  child: const Text('Send Request'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DateContainer extends ConsumerWidget {
  const _DateContainer({
    required this.title,
    required this.backgroundColor,
    this.startDate,
    this.endDate,
    this.onStartDate,
    this.onEndDate,
    this.vacationId,
  });

  final String title;
  final Color backgroundColor;
  final String? startDate;
  final String? endDate;
  final VoidCallback? onStartDate;
  final VoidCallback? onEndDate;
  final String? vacationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppContainer(
      borderRadius: Constant.kNoBorderRadius,
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: TitleText(title)),
              if (vacationId != null) ...[
                const Expanded(flex: 2, child: Text('Godkendt')),
                InkResponse(
                  child: const Icon(Icons.delete, color: Colors.black54),
                  onTap: () =>
                      ref.read(vacationRepoProvider).deleteRequest(vacationId!),
                )
              ],
            ],
          ),
          const SizedBox(height: 12),
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
    );
  }
}
