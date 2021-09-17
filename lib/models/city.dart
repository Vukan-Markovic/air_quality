import 'component.dart';
import 'station.dart';

class City {
  final Station station;
  final List<Component> component;
  final List<double> value;

  City(this.station, this.component, this.value);

  @override
  String toString() =>
      'City(station: $station, components: $component, value: $value)';
}
