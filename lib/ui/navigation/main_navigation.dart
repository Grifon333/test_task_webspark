import 'package:test_task/ui/widgets/home_screen/home_screen.dart';
import 'package:test_task/ui/widgets/preview_screen/preview_screen.dart';
import 'package:test_task/ui/widgets/process_screen/process_screen.dart';
import 'package:test_task/ui/widgets/result_list_screen/result_list_screen.dart';

abstract class MainNavigationRouteName {
  static const home = '/';
  static const process = '/process';
  static const result_list = '/process/result_list';
  static const preview_sceen = '/process/result_list/preview_screen';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.home;
  final routes = {
    MainNavigationRouteName.home : (context) => const HomeScreen(),
    MainNavigationRouteName.process: (context) => const ProcessScreen(),
    MainNavigationRouteName.result_list: (context) => const ResultListScreen(),
    MainNavigationRouteName.preview_sceen: (context) => const PreviewScreen(),
  };
}