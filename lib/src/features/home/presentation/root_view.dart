part of 'home_page.dart';

class _HomeRootView extends ConsumerWidget {
  const _HomeRootView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ImageButton(
          assetPath: AssetsUtil.appBackground,
          title: 'Montage App',
          onTapped: () =>
              ref.read(homeViewProvider.notifier).state = HomeView.montage,
        ),
        _ImageButton(
          assetPath: AssetsUtil.displayBackground,
          title: 'Production App',
          onTapped: () =>
              ref.read(homeViewProvider.notifier).state = HomeView.production,
        ),
        const SizedBox(height: 16),
        AppContainer(
          onTap: () =>
              ref.read(homeViewProvider.notifier).state = HomeView.vacation,
          width: 400,
          height: 72,
          border: Border.all(),
          color: Colors.grey,
          child: const Center(
            child: TitleLarge(
              'Ferie Registrering',
              color: Colors.white,
              textAlign: TextAlign.center,
              fontSize: 36,
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageButton extends StatelessWidget {
  const _ImageButton({
    required this.assetPath,
    required this.title,
    required this.onTapped,
  });

  final String assetPath;
  final String title;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      onTap: onTapped,
      width: 400,
      height: 72,
      padding: EdgeInsets.zero,
      betweenTilePadding: const EdgeInsets.symmetric(vertical: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: Constant.kBorderRadius,
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: TitleLarge(
            title,
            color: Colors.white,
            textAlign: TextAlign.center,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
