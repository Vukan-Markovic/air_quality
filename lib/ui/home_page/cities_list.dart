import '../../models/city.dart';
import 'package:flutter/material.dart';

import 'city_item.dart';

class CitiesList extends StatelessWidget {
  final List<City> cities;

  const CitiesList({Key? key, required this.cities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => CityItem(city: cities[index]),
      itemCount: cities.length,
    );
  }
}
