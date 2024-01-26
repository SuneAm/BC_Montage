import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ordrestyring_display/src/features/case/domain/case.dart';
import 'package:ordrestyring_display/src/providers.dart';

final caseRepoProvider = Provider<CaseRepository>((ref) {
  return CaseRepository(ref);
});

class CaseRepository {
  CaseRepository(this._ref);

  final Ref _ref;

  FirebaseFirestore get _firestore => _ref.read(firestoreProvider);

  Stream<List<Case>> watchCases() {
    final snapshots = _firestore.collection('cases').orderBy('caseNumber', descending: true).snapshots();

    return snapshots.map((snapshot) => snapshot.docs.map((document) => Case.fromFirestore(document.data())).toList());
  }
}
