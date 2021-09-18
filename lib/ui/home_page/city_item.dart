import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/city.dart';
import '../../models/grade.dart';
import '../city_details_page/city_details.dart';

class CityItem extends StatefulWidget {
  final City city;

  const CityItem({Key? key, required this.city}) : super(key: key);

  @override
  State<CityItem> createState() => _CityItemState();
}

class _CityItemState extends State<CityItem> {
  Color textColor = Colors.black;
  late final Grade grade;
  double? value = 0;

  @override
  void initState() {
    super.initState();
    logger.d(widget.city.values);
    widget.city.grades!.forEach((element) {
      logger.e(element.name + element.value.toString());
    });

    grade = widget.city.grades!.reduce((a, b) {
      if (a.value < b.value) {
        return a;
      } else {
        return b;
      }
    });

    value = widget.city.values[widget.city.grades!.indexOf(grade)];

    if (grade.value == 5) {
      textColor = Colors.green;
    } else if (grade.value == 4) {
      textColor = Colors.blueGrey;
    } else if (grade.value == 3) {
      textColor = Colors.yellow;
    } else if (grade.value == 2) {
      textColor = Colors.red;
    } else if (grade.value == 1) {
      textColor = Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CityDetailsPage(city: widget.city),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.city.station.name,
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${widget.city.station.stationClassification}, ${widget.city.station.areaClassification}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            value != null
                ? Text(
                    value!.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  )
                : const Text('nepoznato'),
            if (value != 0.0) ...[
              const SizedBox(width: 8.0),
              Text(
                '(${grade.name})',
              )
            ]
          ],
        ),
      ),
    );
  }
}
