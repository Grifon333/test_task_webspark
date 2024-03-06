import 'package:flutter/material.dart';
import 'package:test_task/domain/entity/way.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

class ResultListScreenModel extends ChangeNotifier {
  List<Way> ways = [];

  void goToNextScreen(BuildContext context, int index) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.preview_screen, arguments: ways[index]);
  }
}

class NotifierProvider extends InheritedNotifier<ResultListScreenModel> {
  final ResultListScreenModel model;

  const NotifierProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static ResultListScreenModel? read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<NotifierProvider>()?.model;
  }

  static ResultListScreenModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider>()
        ?.model;
  }
}