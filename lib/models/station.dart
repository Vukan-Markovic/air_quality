class Station {
  final int id;
  final String name;
  final String startDate;
  final double latitude;
  final double longitude;
  final int? altitude;
  final String? stationClassification;
  final String? areaClassification;
  final String? charOfZone;
  final String? ozoneClassification;
  final String? mainEmissionSource;
  final String city;
  final int? cityPopulation;
  final String? streetName;

  Station(
    this.id,
    this.name,
    this.startDate,
    this.latitude,
    this.longitude,
    this.altitude,
    this.stationClassification,
    this.areaClassification,
    this.charOfZone,
    this.ozoneClassification,
    this.mainEmissionSource,
    this.city,
    this.cityPopulation,
    this.streetName,
  );

  factory Station.fromMap(Map<String, dynamic> map) => Station(
        map['id'],
        map['name'],
        map['startDate'],
        map['latitude'],
        map['longitude'],
        map['altitude'],
        map['stationClassification'],
        map['areaClassification'],
        map['charOfZone'],
        map['ozoneClassification'],
        map['mainEmissionSource'],
        map['city'],
        map['cityPopulation'],
        map['streetName'],
      );

  @override
  String toString() =>
      'Station(id: $id, name: $name, startDate: $startDate, latitude: $latitude, longitude: $longitude, altitude: $altitude, stationClassification: $stationClassification, areaClassification: $areaClassification, charOfZone: $charOfZone, ozoneClassification: $ozoneClassification, mainEmissionSource: $mainEmissionSource, city: $city, cityPopulation: $cityPopulation, streetName: $streetName)';
}
