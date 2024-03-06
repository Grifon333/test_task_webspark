import 'package:flutter/material.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';

class PreviewScreenModel extends ChangeNotifier {
  late final Way way;
  Map<Point, Color> map = {};

  void coloredBox() {
    final steps = way.result.steps;
    map.addAll({steps.first: const Color(0xFF64FFDA)});
    if (steps.length > 1) map.addAll({steps.last: const Color(0xFF009688)});
    for (int i = 1; i < steps.length - 1; i++) {
      map.addAll({steps[i]: const Color(0xFF4CAF50)});
    }
  }
}

class NotifierProvider extends InheritedNotifier<PreviewScreenModel> {
  final PreviewScreenModel model;

  const NotifierProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static PreviewScreenModel? read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<NotifierProvider>()?.model;
  }

  static PreviewScreenModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider>()
        ?.model;
  }
}
