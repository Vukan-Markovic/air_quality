import 'component.dart';
import 'grade.dart';
import 'station.dart';

class City {
  final Station station;
  final List<Component> components;
  final List<double?> values;
  List<Grade>? grades;

  City(this.station, this.components, this.values);

  @override
  String toString() =>
      'City(station: $station, components: $components, values: $values, grades: $grades)';
}
