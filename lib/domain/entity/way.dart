import 'point.dart';

class Way {
  late String id;
  late Result result;

  Way({
    required this.id,
    required this.result,
  });

  Way.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['result'] = result.toJson();
    return data;
  }
}

class Result {
  late List<Point> steps;
  late String path;

  Result({
    required this.steps,
    required this.path,
  });

  Result.fromJson(Map<String, dynamic> json) {
    steps = <Point>[];
    json['steps'].forEach((v) {
      steps.add(Point.fromJson(v));
    });
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['steps'] = steps.map((v) => v.toJson()).toList();
    data['path'] = path;
    return data;
  }
}
