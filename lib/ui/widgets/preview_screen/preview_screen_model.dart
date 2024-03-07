import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_task/domain/box_manager.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';

class PreviewScreenModel extends ChangeNotifier {
  Way? _way;
  Data? _data;
  Map<Point, Color> _coloredCell = {};
  int _size = 1;

  Way? get way => _way;

  Map<Point, Color> get coloredCell => _coloredCell;

  int get size => _size;

  final Color _startColor = const Color(0xFF64FFDA);
  final Color _endColor = const Color(0xFF009688);
  final Color _middleColor = const Color(0xFF4CAF50);
  final Color _blockColor = const Color(0xFF000000);

  void coloredBox() {
    if (_way == null || _data == null) return;
    final field = _data!.field;
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        final String cell = field[i][j];
        if (cell == 'X') {
          _coloredCell.addAll({Point(i, j): _blockColor});
        }
      }
    }
    final steps = _way!.result.steps;
    _coloredCell.addAll({steps.first: _startColor});
    if (steps.length > 1) _coloredCell.addAll({steps.last: _endColor});
    for (int i = 1; i < steps.length - 1; i++) {
      _coloredCell.addAll({steps[i]: _middleColor});
    }
    notifyListeners();
  }

  Future<void> getDataAndWayFromStorage(String id) async {
    if (_data == null) {
      Box<Data> boxData = await BoxManager.instance.openDataBox();
      _data = boxData.get(id);
      await BoxManager.instance.closeBox<Data>(boxData);
    }
    if (_way == null) {
      Box<Way> boxWay = await BoxManager.instance.openWayBox();
      _way = boxWay.get(id);
      await BoxManager.instance.closeBox<Way>(boxWay);
    }
    _size = _data?.field.length ?? 1;
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
