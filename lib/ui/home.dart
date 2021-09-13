import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Air quality'),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
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
  const CitiesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const CityItem();
      },
      itemCount: 10,
    );
  }
}

class CityItem extends StatelessWidget {
  const CityItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Novi Pazar'),
      subtitle: const Text('background, SEPA'),
      trailing: const Text('176'),
      onTap: () {},
    );
  }
}
