import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

import 'clock.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Clock(),
            Spacer(),
            Text(
              'Ordrer i produktion',
              style: TextStyle(
                fontSize: 50,
                fontFamily: "SimplonBPRegular",
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
            ),
            Spacer(),
            Text(
              'Dato: ',
              style: TextStyle(
                fontSize: 24,
                fontFamily: "SimplonBPRegular",
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
            ),
            SizedBox(width: 4),
            _DateWidget(),
            SizedBox(width: 12),
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
      DateFormat('dd - MM - yyyy').format(currentDate.value.toLocal()),
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 53, 53, 53),
      ),
    );
  }
}
