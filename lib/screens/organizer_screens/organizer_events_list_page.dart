import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';

class OrganizerEventsListPage extends StatefulWidget {
  const OrganizerEventsListPage({super.key});

  @override
  State<OrganizerEventsListPage> createState() =>
      _OrganizerEventsListPageState();
}

final List<String> dataList = [
  'Card 1',
  'Card 2',
  'Card 3',
  'Card 4',
  'Card 5',
  'Card 6',
  'Card 7',
  'Card 8',
  'Card 9',
  'Card 10',
];

class _OrganizerEventsListPageState extends State<OrganizerEventsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista događaja"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(dataList[index]),
                subtitle: Text('Subtitle'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Get.toNamed(Routes.organizerEventDetailsPage);
                },
              ),
            );
          }),
    );
  }
}
