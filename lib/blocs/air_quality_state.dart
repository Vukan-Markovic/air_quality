import '../models/city.dart';

abstract class AirQualityState {}

class LoadingAirQualityData extends AirQualityState {}

class ErrorLoadingBookmarkData extends AirQualityState {}

class AirQualityData extends AirQualityState {
  final List<City> cityItems;

  AirQualityData(this.cityItems);
}
