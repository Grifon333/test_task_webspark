import 'package:flutter/material.dart';
import 'package:test_task/domain/entity/way.dart';
import 'package:test_task/ui/widgets/home_screen/home_screen.dart';
import 'package:test_task/ui/widgets/preview_screen/preview_screen.dart';
import 'package:test_task/ui/widgets/process_screen/process_screen.dart';
import 'package:test_task/ui/widgets/result_list_screen/result_list_screen.dart';

abstract class MainNavigationRouteName {
  static const home = '/';
  static const process = '/process';
  static const result_list = '/process/result_list';
  static const preview_screen = '/process/result_list/preview_screen';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteName.home;
  final routes = {
    MainNavigationRouteName.home: (context) => const HomeScreen(),
    MainNavigationRouteName.process: (context) => const ProcessScreen(),
    MainNavigationRouteName.result_list: (context) => const ResultListScreen(),
    // MainNavigationRouteName.preview_screen: (context) => const PreviewScreen(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case MainNavigationRouteName.process:
      //   final argument = settings.arguments;
      //   final listData = argument as Future<List<Data>>;
      //   return MaterialPageRoute(
      //     builder: (context) => ProcessScreen(
      //       data: listData,
      //     ),
      //   );
      // case MainNavigationRouteName.result_list:
      //   final argument = settings.arguments;
      //   final listWays = argument as List<Way>;
      //   return MaterialPageRoute(
      //     builder: (context) => ResultListScreen(
      //       listWays: listWays,
      //     ),
      //   );
      case MainNavigationRouteName.preview_screen:
        final argument = settings.arguments;
        final idWay = argument as String;
        return MaterialPageRoute(
          builder: (context) => PreviewScreen(
            idWay: idWay,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Navigation error'),
            ),
          ),
        );
    }
  }
}
