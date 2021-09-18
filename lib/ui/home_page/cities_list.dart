import '../../models/city.dart';
import 'package:flutter/material.dart';

import 'city_item.dart';

class CitiesList extends StatelessWidget {
  final List<City> cities;
  final Future<void> Function() refreshData;

  const CitiesList({
    Key? key,
    required this.cities,
    required this.refreshData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => CityItem(city: cities[index]),
        itemCount: cities.length,
      ),
    );
  }
}
