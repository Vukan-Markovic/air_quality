import 'package:air_quality/ui/city_details_page/city_details_item.dart';

import '../../models/city.dart';
import 'package:flutter/material.dart';

class CityDetailsPage extends StatelessWidget {
  final City city;

  const CityDetailsPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CityDetailsItem(
              attribute: 'Naziv stanice',
              value: city.station.name,
            ),
            CityDetailsItem(
              attribute: 'Početak rada',
              value: city.station.startDate,
            ),
            CityDetailsItem(
              attribute: 'Pripada mreži',
              value: city.station.city,
            ),
            CityDetailsItem(
              attribute: 'Klasifikacija',
              value: city.station.city,
            ),
            CityDetailsItem(
              attribute: 'Zona',
              value: city.station.city,
            ),
            CityDetailsItem(
              attribute: 'Latitude',
              value: city.station.latitude.toString(),
            ),
            CityDetailsItem(
              attribute: 'Longitude',
              value: city.station.longitude.toString(),
            ),
            if (city.station.altitude != null)
              CityDetailsItem(
                attribute: 'Altitude',
                value: city.station.altitude.toString(),
              ),
            const Text('Agencija za zaštitu životne sredine'),
            const Text('www.amskv.sepa.gov.rs'),
          ],
        ),
      ),
    );
  }
}
