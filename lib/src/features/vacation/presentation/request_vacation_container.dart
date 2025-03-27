import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

class RequestVacationContainer extends HookConsumerWidget {
  const RequestVacationContainer({
    this.vacation,
    this.onCreateVacation,
    super.key,
  });

  final Vacation? vacation;
  final void Function(TZDateTimeRange datesRange)? onCreateVacation;

  bool get isPreviewing => vacation != null;

  TZDateTimeRange? get vacationDateRange => vacation != null
      ? TZDateTimeRange(
          start: vacation!.calendar.startDate, end: vacation!.calendar.endDate)
      : null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTimeRange = useState<TZDateTimeRange?>(vacationDateRange);

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
              dateTimeRange: dateTimeRange.value,
              vacationId: vacation?.id,
              backgroundColor: isPreviewing
                  ? Colors.greenAccent.shade100
                  : Colors.grey.shade300,
              onStartDate: isPreviewing
                  ? null
                  : () async {
                      final selectedDateRange = await context.selectDateRange(
                        'Select',
                        initialDateRange: dateTimeRange.value,
                      );

                      if (selectedDateRange != null) {
                        dateTimeRange.value = selectedDateRange;
                      }
                    },
            ),
            if (!isPreviewing) ...[
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('Send Request'),
                  onPressed: () async {
                    final dateRange = dateTimeRange.value;
                    if (dateRange == null) return;

                    onCreateVacation?.call(dateRange);

                    if (context.mounted) {
                      // context.showSnackBar('Vacation Request Send');
                      // dateTimeRange.value = null;
                    }
                  },
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
    required this.backgroundColor,
    required this.dateTimeRange,
    this.onStartDate,
    this.vacationId,
  });

  final TZDateTimeRange? dateTimeRange;
  final Color backgroundColor;
  final VoidCallback? onStartDate;
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
              const Expanded(child: TitleText('Ferie ')),
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
              const Expanded(child: Text('Datoer')),
              Expanded(
                flex: 2,
                child: AppContainer(
                  borderRadius: Constant.kNoBorderRadius,
                  border: Border.all(),
                  padding: const EdgeInsets.all(4),
                  child: Text(dateTimeRange == null
                      ? ''
                      : '${dateTimeRange!.start.formatDate} - ${dateTimeRange!.end.formatDate}'),
                ),
              ),
              const SizedBox(width: 8),
              InkResponse(
                onTap: onStartDate,
                child: const Icon(Icons.calendar_month),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
