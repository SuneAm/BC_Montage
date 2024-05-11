import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';
import 'package:ordrestyring_montage/src/features/vacation/presentation/request_vacation_dialog.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/appbar_background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Clock(),
            const Text(
              'BC',
              style: TextStyle(
                fontSize: 22,
                fontFamily: "SimplonBPRegular",
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 228, 0, 0),
              ),
            ),
            const Spacer(),
            const Text(
              '                Ordrer i Montage',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "SimplonBPRegular",
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
            ),
            const Spacer(),
            IconContainer(
              icon: Icons.add_circle,
              size: 28,
              onTap: () => context.openDialog(const RequestVacationDialog()),
            ),
            const SizedBox(width: 4),
            const Text(
              'Dato:',
              style: TextStyle(
                fontSize: 12,
                fontFamily: "SimplonBPRegular",
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
            ),
            const SizedBox(width: 2),
            const _DateWidget(),
            // SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

class _DateWidget extends HookWidget {
  const _DateWidget();

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = useState(DateTime.now());

    useEffect(() {
      final timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
        final newDate = DateTime.now();
        if (!isSameDay(currentDate.value, newDate)) {
          currentDate.value = newDate;
        }
      });

      return () => timer.cancel();
    }, const []);

    return Text(
      DateFormat('dd-MM-yyyy').format(currentDate.value.toLocal()),
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 53, 53, 53),
      ),
    );
  }
}
