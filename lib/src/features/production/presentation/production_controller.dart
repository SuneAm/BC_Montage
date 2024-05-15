part of 'production_view.dart';

final productionCasesProvider = Provider<List<Case>>((ref) {
  return ref.watch(watchProduktionCases).asData?.value ?? [];
});
