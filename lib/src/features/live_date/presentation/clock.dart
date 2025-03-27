import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

const double _edgeWidth = 6.0; // side margin

class Clock extends HookWidget {
  const Clock({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTime = useState(DateTime.now());
    const TextStyle txtStyle = TextStyle(
      color: Color.fromARGB(255, 65, 65, 65),
      fontSize: 60,
      fontWeight: FontWeight.w600,
    );

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => currentTime.value = DateTime.now(),
      );

      return () => timer.cancel();
    }, const []);

    final now = currentTime.value.toLocal();

    return Row(
      children: [
        Text(now.hour.toString().padLeft(2, '0'), style: txtStyle),
        const SizedBox(width: _edgeWidth),
        const Text(
          ":",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: "digital-7",
            color: Color.fromARGB(62, 65, 65, 65),
          ),
        ),
        const SizedBox(width: _edgeWidth),
        Text(now.minute.toString().padLeft(2, '0'), style: txtStyle),
        const SizedBox(width: _edgeWidth),
/*        const Text(
          ":",
          style: TextStyle(
            fontSize: 60.0,
            fontWeight: FontWeight.bold,
            fontFamily: "digital-7",
            color: Color.fromARGB(255, 65, 65, 65),
          ),
        ),
        const SizedBox(width: _edgeWidth),
        Text(
          now.second.toString().padLeft(2, '0'),
          style: txtStyle,
        ),*/
      ],
    );
  }
}
