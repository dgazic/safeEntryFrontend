import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';

class SecurityOrganizersListPage extends StatefulWidget {
  const SecurityOrganizersListPage({super.key});

  @override
  State<SecurityOrganizersListPage> createState() =>
      _SecurityOrganizersListPageState();
}

class _SecurityOrganizersListPageState
    extends State<SecurityOrganizersListPage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista organizatora"),
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
                  Get.toNamed(Routes.securityEventDetailsPage);
                },
              ),
            );
          }),
    );
  }
}
