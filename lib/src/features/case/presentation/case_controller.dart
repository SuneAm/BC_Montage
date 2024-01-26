import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ordrestyring_display/src/features/case/data/case_repostiory.dart';
import 'package:ordrestyring_display/src/features/case/domain/case.dart';

final watchCasesProvider = StreamProvider<List<Case>>((ref) => ref.watch(caseRepoProvider).watchCases());
