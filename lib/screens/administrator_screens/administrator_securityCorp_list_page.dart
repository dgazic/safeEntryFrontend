import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/models/user_model.dart';
import 'package:safe_entry/providers/user_provider.dart';

class AdministratorSecurityCorpListPage extends StatefulWidget {
  const AdministratorSecurityCorpListPage({super.key});

  @override
  State<AdministratorSecurityCorpListPage> createState() =>
      _AdministratorSecurityCorpListPageState();
}

class _AdministratorSecurityCorpListPageState
    extends State<AdministratorSecurityCorpListPage> {
  UserProvider userProvider = UserProvider();
  late Future<List<UserResponseModel>> usersFuture;
  void initState() {
    super.initState();
    var fetchUsers = userProvider.fetchUsers();
    usersFuture = fetchUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista organizatora"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var users = snapshot.data!;
            return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 6.0, right: 6.0, bottom: 6.0),
                      child: ExpansionTile(
                        title: Text(user.companyName!),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Opis organizatora"),
                                                    content: Container(
                                                      height: 200,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              "Ime organizatora: "),
                                                          SelectableText(
                                                            user.firstName!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                              "Adresa organizatora: "),
                                                          SelectableText(
                                                            user.address!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                              "Email adresa organizatora: "),
                                                          SelectableText(
                                                            user.email!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(height: 8.0),
                                                          Text(
                                                              "Broj telefona organizatora: "),
                                                          SelectableText(
                                                            user.phoneNumber!,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              Text("Zatvori"))
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
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
