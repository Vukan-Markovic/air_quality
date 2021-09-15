import 'dart:convert';

class Component {
  final int id;
  final String shortName;
  final String matrix;
  final String name;
  final String unit;

  Component(this.id, this.shortName, this.matrix, this.name, this.unit);

  factory Component.fromMap(Map<String, dynamic> map) => Component(
        map['id'],
        map['shortName'],
        map['matrix'],
        map['name'],
        map['unit'],
      );

  factory Component.fromJson(String source) =>
      Component.fromMap(json.decode(source));

  @override
  String toString() =>
      'Component(id: $id, shortName: $shortName, matrix: $matrix, name: $name, unit: $unit)';
}
