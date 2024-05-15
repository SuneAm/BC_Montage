part of 'home_page.dart';

enum HomeView { root, montage, production, vacation }

final homeViewProvider = StateProvider.autoDispose<HomeView>(
  (ref) => HomeView.root,
);
