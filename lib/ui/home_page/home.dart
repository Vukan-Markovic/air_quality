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
      appBar: AppBar(title: const Text('Air quality')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${DateFormat('dd.MM.yyyy. HH:mm').format(
                DateTime(
                  DateTime.now().day,
                  DateTime.now().month,
                  DateTime.now().year,
                  DateTime.now().hour - 2,
                ),
              )} - ${DateFormat('HH:mm').format(DateTime(DateTime.now().hour - 1))}',
              style: const TextStyle(
                fontSize: 18.0,
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
                      ),
                    );
                }
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
