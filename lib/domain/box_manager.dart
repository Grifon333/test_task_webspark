import 'package:hive/hive.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/domain/entity/way.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = {};

  BoxManager._();

  Future<Box<T>> _openBox<T>(
    int typeId,
    TypeAdapter<T> adapter,
    String boxName,
  ) async {
    if (Hive.isBoxOpen(boxName)) {
      final count = _boxCounter[boxName] ?? 1;
      _boxCounter[boxName] = count + 1;
      return Hive.box(boxName);
    }
    _boxCounter[boxName] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(boxName);
  }

  Future<Box<Data>> openDataBox() async {
    return _openBox(0, DataAdapter(), 'data');
  }

  Future<Box<Way>> openWayBox() async {
    return _openBox(2, WayAdapter(), 'way');
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    var count = _boxCounter[box.name] ?? 1;
    count--;
    _boxCounter[box.name] = count;
    if (count > 0) return;

    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }
}
