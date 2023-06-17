import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';
import 'package:safe_entry/screens/administrator_screens/administrator_securityCorp_list_page.dart';
import 'package:safe_entry/screens/administrator_screens/administrator_security_registration.dart';
import 'package:safe_entry/screens/administrator_screens/administrator_welcome_page.dart';

class AdministratorHomePage extends StatefulWidget {
  const AdministratorHomePage({super.key});

  @override
  State<AdministratorHomePage> createState() => _AdministratorHomePageState();
}

class _AdministratorHomePageState extends State<AdministratorHomePage> {
  List adminPages = [
    AdministratorWelcomePage(),
    AdministratorSecurityRegistrationPage(),
    AdministratorSecurityCorpListPage()
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Administration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Želite li se odjaviti?"),
                        actions: <Widget>[
                          new ElevatedButton.icon(
                            label: Text("Da"),
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              Get.offAllNamed(Routes.home);
                            },
                          ),
                          new ElevatedButton.icon(
                            label: Text("Ne"),
                            icon: Icon(Icons.block),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ],
                      ));
            },
          ),
        ],
      ),
      body: adminPages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedFontSize: 20,
          unselectedFontSize: 14,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Početna"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: "Dodavanje organizatora"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event), label: "Organizatori lista"),
          ]),
    );
  }
}
