import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';
import 'package:safe_entry/screens/security_screens/security_events_list_page.dart';
import 'package:safe_entry/screens/security_screens/security_organizer_registration_page.dart';
import 'package:safe_entry/screens/security_screens/security_organizers_list_page.dart';
import 'package:safe_entry/screens/security_screens/security_welcome_page.dart';

class SecurityHomePage extends StatefulWidget {
  const SecurityHomePage({super.key});

  @override
  State<SecurityHomePage> createState() => _SecurityHomePageState();
}

class _SecurityHomePageState extends State<SecurityHomePage> {
  List adminPages = [
    SecurityWelcomePage(),
    SecurityEventsListPage(),
    SecurityOrganizerRegistrationPage(),
    SecurityOrganizersListPage()
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
        title: Text("Security corp. administration"),
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
                icon: Icon(Icons.insert_invitation), label: "Lista evenata"),
            BottomNavigationBarItem(
                icon: Icon(Icons.app_registration),
                label: "Registracija organizatora"),
            BottomNavigationBarItem(
                icon: Icon(Icons.corporate_fare_outlined),
                label: "Lista organizatora"),
          ]),
    );
  }
}
