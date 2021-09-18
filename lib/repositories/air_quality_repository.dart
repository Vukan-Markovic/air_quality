import 'dart:convert';
import 'dart:io';
import '../blocs/air_quality_state.dart';
import '../models/component.dart';
import '../models/grade.dart';
import '../models/station.dart';
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

  Future<AirQualityState> getCitiesData() async {
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

        final cities = List<City>.from(
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
              List<double?>.from(
                record.value
                    .map((r) => (r as Map<String, dynamic>)['value'])
                    .toList(),
              ),
            ),
          ),
        );

        for (var city in cities) {
          city.grades = [];

          for (var index = 0; index < city.values.length; index++) {
            final value = city.values[index];
            if (value != null) {
              if (city.components[index].id == 1) {
                if (value >= 0 && value <= 50) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 50 && value <= 100) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 100 && value <= 350) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 350 && value <= 500) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 500) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              } else if (city.components[index].id == 7) {
                if (value >= 0 && value <= 60) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 60 && value <= 120) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 120 && value <= 180) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 180 && value <= 240) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 240) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              } else if (city.components[index].id == 10) {
                if (value >= 0 && value <= 5) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 5 && value <= 10) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 10 && value <= 25) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 25 && value <= 50) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 50) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              } else if (city.components[index].id == 6001) {
                if (value >= 0 && value <= 15) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 15 && value <= 30) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 30 && value <= 55) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 55 && value <= 110) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 110) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              } else if (city.components[index].id == 5) {
                if (value >= 0 && value <= 25) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 25 && value <= 50) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 50 && value <= 90) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 90 && value <= 180) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 180) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              } else if (city.components[index].id == 8) {
                if (value >= 0 && value <= 50) {
                  city.grades?.add(Grade(city.components[index].shortName, 5));
                } else if (value > 50 && value <= 100) {
                  city.grades?.add(Grade(city.components[index].shortName, 4));
                } else if (value > 100 && value <= 150) {
                  city.grades?.add(Grade(city.components[index].shortName, 3));
                } else if (value > 150 && value <= 400) {
                  city.grades?.add(Grade(city.components[index].shortName, 2));
                } else if (value > 400) {
                  city.grades?.add(Grade(city.components[index].shortName, 1));
                }
              }
            }
          }
        }

        return AirQualityData(cities.sorted(
          (a, b) => a.grades!.reduce((a, b) {
            if (a.value < b.value) {
              return a;
            } else {
              return b;
            }
          }).compareTo(b.grades!.reduce((a, b) {
            if (a.value < b.value) {
              return a;
            } else {
              return b;
            }
          })),
        ));
      } else {
        logger.e('Error getting air quality data, response: ${response.body}');
        return ServerError();
      }
    } on SocketException {
      logger.e('No internet connection!');
      return OfflineError();
    } catch (error) {
      logger.e('Error: $error!');
      return ServerError();
    }
  }
}
