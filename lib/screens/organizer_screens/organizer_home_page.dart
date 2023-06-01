import 'package:flutter/material.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_events_list_page.dart';
import 'package:safe_entry/screens/organizer_screens/organizer_invitation_page.dart';
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
    OrganizerEventsListPage()
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
          ]),
    );
  }
}
