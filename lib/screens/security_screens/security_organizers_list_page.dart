import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              child: Padding(
                padding: EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0),
                child: ExpansionTile(
                  title: Text('Birth of Universe'),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 140,
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Opis organizatora"),
                                              content: Container(
                                                height: 200,
                                                child: Column(
                                                  children: [
                                                    Text("Ime organizatora: "),
                                                    SelectableText(
                                                      "Privatna firma pula d.o.o",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Text(
                                                        "Adresa organizatora: "),
                                                    SelectableText(
                                                      "Preradovićeva 28a",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Text(
                                                        "Email adresa organizatora: "),
                                                    SelectableText(
                                                      "privatna.firma@gmail.com",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(height: 8.0),
                                                    Text(
                                                        "Broj telefona organizatora: "),
                                                    SelectableText(
                                                      "095/396-0923",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text("Zatvori"))
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.account_box),
                                    label: Text("Opis")),
                              ),
                              SizedBox(width: 8),
                              Container(
                                height: 35,
                                width: 140,
                                child: ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.disabled_by_default),
                                    label: Text("Deaktiviraj")),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
