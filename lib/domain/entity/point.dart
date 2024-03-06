class Point {
  late int x;
  late int y;

  Point(
      this.x,
      this.y,
      );

  Point.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['x'] = x;
    data['y'] = y;
    return data;
  }

  @override
  String toString() {
    return '($x,$y)';
  }

  @override
  int get hashCode => x * 1000 + y;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != Point) return false;
    Point point = other as Point;
    return point.hashCode == hashCode && point.x == x && point.y == y;
  }
}