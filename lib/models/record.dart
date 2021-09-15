class Record {
  final int stationId;
  final int componentId;
  final double value;

  Record(this.stationId, this.componentId, this.value);

  factory Record.fromMap(Map<String, dynamic> map) =>
      Record(map['station_id'], map['component_id'], map['value']);

  @override
  String toString() =>
      'Record(stationId: $stationId, componentId: $componentId, value: $value)';
}
