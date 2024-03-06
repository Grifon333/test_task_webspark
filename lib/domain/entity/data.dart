import 'point.dart';

class Data {
  late String id;
  late List<String> field;
  late Point start;
  late Point end;

  Data({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    field = json['field'].cast<String>();
    start = Point.fromJson(json['start']);
    end = Point.fromJson(json['end']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['field'] = field;
    data['start'] = start.toJson();
    data['end'] = end.toJson();
    return data;
  }

  @override
  String toString() {
    List<String> str = [];
    str.addAll(field);
    str.add('start: $start');
    str.add('end: $end');
    return str.join('\n');
  }
}
