import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_task/domain/box_manager.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';

class PreviewScreenModel extends ChangeNotifier {
  Way? way;
  Data? data;
  Map<Point, Color> map = {};
  int size = 1;

  final Color _startColor = const Color(0xFF64FFDA);
  final Color _endColor = const Color(0xFF009688);
  final Color _middleColor = const Color(0xFF4CAF50);
  final Color _blockColor = const Color(0xFF000000);

  void coloredBox() {
    if (way == null || data == null) return;
    final field = data!.field;
    for(int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        final String cell = field[i][j];
        if (cell == 'X') {
          map.addAll({Point(i,j): _blockColor});
        }
      }
    }
    final steps = way!.result.steps;
    map.addAll({steps.first: _startColor});
    if (steps.length > 1) map.addAll({steps.last: _endColor});
    for (int i = 1; i < steps.length - 1; i++) {
      map.addAll({steps[i]: _middleColor});
    }
    notifyListeners();
  }

  Future<void> getDataAndWayFromStorage(String id) async {
    if (data == null) {
      Box<Data> boxData = await BoxManager.instance.openDataBox();
      data = boxData.get(id);
      await BoxManager.instance.closeBox<Data>(boxData);
    }
    if (way == null) {
      Box<Way> boxWay = await BoxManager.instance.openWayBox();
      way = boxWay.get(id);
      await BoxManager.instance.closeBox<Way>(boxWay);
    }
    size = data?.field.length ?? 1;
    notifyListeners();
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
