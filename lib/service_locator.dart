import 'package:get_it/get_it.dart';

import 'blocs/air_quality_bloc.dart';
import 'repositories/air_quality_repository.dart';
import 'services/http_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton(HttpService());
  getIt.registerFactory<AirQualityBloc>(() => AirQualityBloc());

  getIt.registerLazySingleton<AirQualityRepository>(
    () => AirQualityRepository(),
  );
}
