import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/routes/routes_manager.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_events_list_page.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_invitation_page.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_registration_event_page.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_welcome_page.dart';

class OrganizerHomePage extends StatefulWidget {
  const OrganizerHomePage({super.key});

  @override
  State<OrganizerHomePage> createState() => _OrganizerHomePageState();
}

class _OrganizerHomePageState extends State<OrganizerHomePage> {
  List adminPages = [
    OrganizerWelcomePage(),
    OrganizerInvitationSendPage(),
    OrganizerEventsListPage(),
    OrganizerRegistrationEventPage()
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
        title: Text("Organizator administration"),
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
                icon: Icon(Icons.insert_invitation),
                label: "Pozivanje na event"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event_available), label: "Eventi"),
            BottomNavigationBarItem(
                icon: Icon(Icons.event_note), label: "Registracija eventa"),
          ]),
    );
  }
}
