import 'dart:convert';
import 'dart:io';
import 'package:air_quality/models/component.dart';
import 'package:air_quality/models/station.dart';
import 'package:collection/collection.dart';

import '../models/city.dart';
import '../services/http_service.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../main.dart';
import '../service_locator.dart';

class AirQualityRepository {
  final _httpService = getIt.get<HttpService>();

  Future<List<City>?> getCitiesData() async {
    try {
      final now = DateTime.now();

      var formattedDate = DateFormat('yyyy-MM-ddTHH:mm').format(
        DateTime(now.year, now.month, now.day, now.hour - 2),
      );

      final response = await _httpService.get('$baseUrlSepa&q=$formattedDate');

      if (response.statusCode == 200) {
        var records = groupBy(
          (jsonDecode(response.body)['result']['records']),
          (record) => (record as Map<String, dynamic>)['station_id'],
        );

        final jsonStringStation = await rootBundle.loadString(
          'assets/json/station.json',
        );

        final stations = jsonDecode(jsonStringStation) as List<dynamic>;

        final jsonStringComponent = await rootBundle.loadString(
          'assets/json/component.json',
        );

        final components = jsonDecode(jsonStringComponent) as List<dynamic>;

        return List<City>.from(
          records.entries.map(
            (record) => City(
              Station.fromMap(
                stations.firstWhere(
                  (station) =>
                      (station as Map<String, dynamic>)['id'] == record.key,
                ),
              ),
              List<Component>.from(
                record.value
                    .map(
                      (r) => Component.fromMap(
                        components.firstWhere(
                          (component) =>
                              (component as Map<String, dynamic>)['id'] ==
                              (r as Map<String, dynamic>)['component_id'],
                        ),
                      ),
                    )
                    .toList(),
              ),
              List<double>.from(
                record.value
                    .map((r) => (r as Map<String, dynamic>)['value'])
                    .toList(),
              ),
            ),
          ),
        );

        // for (var city in cities) {
        // final response = await _httpService.get(
        //   '$baseUrlAqicn${city.station.name}/?token=0e5c4296b0100658a6796fdb1b1e3d21a2ed5037',
        // );

        // city.component.add(
        //   Component(0, 'AQI', '', 'Indeks kvaliteta vazduha', ''),
        // );

        // logger.e(jsonDecode(response.body)['data']);
        // city.value.add(jsonDecode(response.body)['data']['aqi']);
        // }
      } else {
        logger.e('Error getting air quality data, response: ${response.body}');
      }
    } on SocketException {
      logger.e('No internet connection!');
    }
  }
}
