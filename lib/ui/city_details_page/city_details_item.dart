import 'package:flutter/material.dart';

class CityDetailsItem extends StatelessWidget {
  final String attribute;
  final String value;

  const CityDetailsItem({
    Key? key,
    required this.attribute,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(attribute),
        Text(value),
      ],
    );
  }
}
