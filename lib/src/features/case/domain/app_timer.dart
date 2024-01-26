import 'package:cloud_firestore/cloud_firestore.dart';

class AppTimer {
  AppTimer({required this.id, required this.timer});

  final String id;
  final int timer;

  Map<String, dynamic> toMap() => {'timer': timer};

  factory AppTimer.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    if (data.isEmpty) return AppTimer(id: '', timer: 0);

    return AppTimer(
      id: snap.id,
      timer: snap['timer'] as int? ?? 0,
    );
  }
}
