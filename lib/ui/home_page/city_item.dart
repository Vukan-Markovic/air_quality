import '../../models/city.dart';
import '../city_details_page/city_details.dart';
import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  final City city;

  const CityItem({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(city.station.city),
      subtitle: Text('${city.station.stationClassification}, SEPA'),
      trailing: Text(city.value.toString()),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CityDetailsPage(city: city),
        ),
      ),
    );
  }
}
