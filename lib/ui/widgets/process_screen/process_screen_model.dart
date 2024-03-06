import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_task/domain/api_client.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/domain/entity/point.dart';
import 'package:test_task/domain/entity/way.dart';
import 'package:test_task/ui/navigation/main_navigation.dart';

class ProcessScreenModel extends ChangeNotifier {
  Future<List<Data>> _dataList;
  List<Data> dataList = [];
  Map<Point, Point> _steps = {};
  List<List<bool>> _visitedMatrix = [];
  List<Way> _ways = [];
  final List<Point> _moving = [
    Point(1, 0),
    Point(-1, 0),
    Point(0, 1),
    Point(0, -1),
    Point(1, 1),
    Point(1, -1),
    Point(-1, 1),
    Point(-1, -1),
  ];
  double progress = 0;
  String textForLoading =
      'All calculation has finished, you can send your result to server';
  bool isDataSending = false;

  ProcessScreenModel(this._dataList);

  void startProcess() async {
    dataList = await _dataList;
    for (int i = 0; i < dataList.length; i++) {
      _generateMatrix(i);
      Data data = dataList[i];
      _bfs(data.start, data.end);
      final way = _restoreWay(data.end);
      _updateWaysData(i, way);
      progress = 100 * (i + 1) / dataList.length;
      sleep(const Duration(seconds: 2));
      debugPrint(progress.toString());
      notifyListeners();
    }
  }

  void _generateMatrix(int index) {
    _visitedMatrix.clear();
    List<String> field = dataList[index].field;
    int countRows = field.length;
    int countColumns = field[0].length;
    _visitedMatrix =
        List.generate(countRows, (index) => List.filled(countColumns, false));
    for (int i = 0; i < countRows; i++) {
      String row = field[i];
      for (int j = 0; j < countColumns; j++) {
        if (row[j] == 'X') {
          _visitedMatrix[i][j] = true;
        }
      }
    }
  }

  void _bfs(Point start, Point end) {
    _steps.clear();
    _steps.addAll({start: Point(-1, -1)});
    int x = start.x;
    int y = start.y;
    _visitedMatrix[x][y] = true;
    var queue = Queue<Point>();
    queue.add(start);
    while (queue.isNotEmpty) {
      Point point = queue.removeFirst();
      for (Point move in _moving) {
        int newX = point.x + move.x;
        int newY = point.y + move.y;
        if (newX < 0 ||
            newX > _visitedMatrix.length - 1 ||
            newY < 0 ||
            newY > _visitedMatrix[0].length - 1) continue;
        if (_visitedMatrix[newX][newY]) continue;
        _visitedMatrix[newX][newY] = true;
        Point newPoint = Point(newX, newY);
        _steps.addAll({newPoint: point});
        queue.add(newPoint);
        if (newPoint == end) return;
      }
    }
  }

  List<Point> _restoreWay(Point end) {
    List<Point> way = [end];
    Point? prev = _steps[end];
    while (prev != Point(-1, -1) && prev != null) {
      way.add(prev);
      prev = _steps[prev];
    }
    return way.reversed.toList();
  }

  void _updateWaysData(int index, List<Point> steps) {
    final data = dataList[index];
    String path = steps.join('->');
    final result = Result(steps: steps, path: path);
    final way = Way(id: data.id, result: result);
    _ways.add(way);
  }

  Future<void> sendResultToServer(BuildContext context) async {
    isDataSending = true;
    notifyListeners();
    await ApiClient().sendData(_ways);
    isDataSending = false;
    notifyListeners();

    _goToNextScreen(context);
  }

  void _goToNextScreen(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteName.preview_sceen);
  }
}

class NotifierProvider extends InheritedNotifier<ProcessScreenModel> {
  final ProcessScreenModel model;

  const NotifierProvider({
    super.key,
    required super.child,
    required this.model,
  }) : super(notifier: model);

  static ProcessScreenModel? read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<NotifierProvider>()?.model;
  }

  static ProcessScreenModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NotifierProvider>()
        ?.model;
  }
}