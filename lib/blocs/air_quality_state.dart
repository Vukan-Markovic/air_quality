import '../models/city.dart';

abstract class AirQualityState {}

class LoadingAirQualityData extends AirQualityState {}

class ServerError extends AirQualityState {}

class OfflineError extends AirQualityState {}

class AirQualityData extends AirQualityState {
  final List<City> cityItems;

  AirQualityData(this.cityItems);
}
