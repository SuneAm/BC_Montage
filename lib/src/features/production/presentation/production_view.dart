import 'package:flutter/cupertino.dart';
import 'package:ordrestyring_common/ordrestyring_common.dart';

part 'production_controller.dart';

class ProductionView extends ConsumerWidget {
  const ProductionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonAsyncWidget(
      asyncValue: ref.watch(watchProduktionCases),
      data: (cases) => CasesListView(
        length: cases.length,
        itemBuilder: (context, index) => ProductionCaseItem(cases[index]),
      ),
    );
  }
}
