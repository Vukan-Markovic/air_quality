import 'component.dart';
import 'station.dart';

class City {
  final Station station;
  final Component component;
  final double value;

  City(this.station, this.component, this.value);

  @override
  String toString() =>
      'City(station: $station, components: $component, value: $value)';
}
