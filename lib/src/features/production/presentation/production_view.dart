import 'package:flutter/cupertino.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

class ProductionView extends ConsumerWidget {
  const ProductionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cases = ref.watch(productionCasesProvider);
    return CasesListView(
      length: cases.length,
      itemBuilder: (context, index) => ProductionCaseItem(cases[index]),
    );
  }
}
