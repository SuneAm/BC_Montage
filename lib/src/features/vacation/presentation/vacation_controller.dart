part of 'vacation_view.dart';

final _getApprovedRequestProvider = StreamProvider.autoDispose<List<Vacation>>(
  (ref) => ref.watch(vacationRepoProvider).getApprovedRequest(),
);
