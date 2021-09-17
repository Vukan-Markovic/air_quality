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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              attribute,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                value,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
