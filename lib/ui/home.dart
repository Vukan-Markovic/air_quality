import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Air quality'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Date time',
            ),
          ),
          Expanded(
            child: CitiesList(),
          ),
        ],
      ),
    );
  }
}

class CitiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CityItem();
      },
      itemCount: 10,
    );
  }
}

class CityItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Novi Pazar'),
      subtitle: Text('background, SEPA'),
      trailing: Text('176'),
      onTap: () {},
    );
  }
}
