import 'dart:convert';
import 'dart:io';
import 'package:air_quality/models/component.dart';
import 'package:air_quality/models/station.dart';
import 'package:collection/collection.dart';

import '../models/city.dart';
import '../models/record.dart';
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

      final response = await _httpService.get('$baseUrl&q=$formattedDate');

      if (response.statusCode == 200) {
        logger.e(jsonDecode(response.body)['result']['records']);
        final records = List<Record>.from(
          jsonDecode(response.body)['result']['records'].map(
            (record) => Record.fromMap(record),
          ),
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
          records.map(
            (record) => City(
              Station.fromMap(
                stations.firstWhere(
                  (element) =>
                      (element as Map<String, dynamic>)['id'] ==
                      record.stationId,
                ),
              ),
              Component.fromMap(
                components.firstWhere(
                  (element) =>
                      (element as Map<String, dynamic>)['id'] ==
                      record.componentId,
                ),
              ),
              record.value,
            ),
          ),
        );
      } else {
        logger.e('Error getting air quality data, response: ${response.body}');
      }
    } on SocketException {
      logger.e('No internet connection!');
    }
  }
}
