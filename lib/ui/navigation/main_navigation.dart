import 'package:test_task/ui/widgets/home_screen/home_screen.dart';

abstract class MainNavigationRouteName {
  static const home = '';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.home;
  final routes = {
    MainNavigationRouteName.home : (context) => const HomeScreen(),
  };
}