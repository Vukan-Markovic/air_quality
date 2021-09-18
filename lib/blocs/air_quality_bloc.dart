import 'dart:async';

import 'air_quality_state.dart';
import '../repositories/air_quality_repository.dart';

import '../service_locator.dart';

class AirQualityBloc {
  final _airQualityRepository = getIt.get<AirQualityRepository>();
  final _streamController = StreamController<AirQualityState>();

  Stream<AirQualityState> get airQualityStream => _streamController.stream;

  Future<void> getCitiesData() async {
    _streamController.sink.add(LoadingAirQualityData());
    _streamController.sink.add(await _airQualityRepository.getCitiesData());
  }
}
