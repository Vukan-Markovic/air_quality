import 'error_screen.dart';

import '../../blocs/air_quality_bloc.dart';
import '../../blocs/air_quality_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service_locator.dart';
import 'cities_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _airQualityBloc = getIt<AirQualityBloc>();
  Stream<AirQualityState>? _citiesStream;

  @override
  void initState() {
    super.initState();
    _airQualityBloc.getCitiesData();
    _citiesStream = _airQualityBloc.airQualityStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kvalitet vazduha')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '${DateFormat('dd.MM.yyyy. HH').format(
                  DateTime.now().subtract(
                    const Duration(hours: 2),
                  ),
                )}:00 - ${DateFormat('HH').format(
                  DateTime.now().subtract(
                    const Duration(hours: 2),
                  ),
                )}:59',
                style: const TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          StreamBuilder<AirQualityState>(
            stream: _citiesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.runtimeType) {
                  case AirQualityData:
                    return Expanded(
                      child: CitiesList(
                        cities: (snapshot.data as AirQualityData).cityItems,
                        refreshData: _getData,
                      ),
                    );

                  case OfflineError:
                    return Expanded(
                      child: ErrorScreen(
                        message:
                            'Internet nije dostupan! Obezbedite konekciju i pokušajte ponovo.',
                        retryCallback: _getData,
                      ),
                    );

                  case ServerError:
                    return Expanded(
                      child: ErrorScreen(
                        message: 'Greška na serveru! Pokušajte ponovo.',
                        retryCallback: _getData,
                      ),
                    );

                  case LoadingAirQualityData:
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                }
              }

              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _getData() async {
    await _airQualityBloc.getCitiesData();
    _citiesStream = _airQualityBloc.airQualityStream;
  }
}
