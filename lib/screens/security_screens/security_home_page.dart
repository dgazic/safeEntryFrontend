import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:safe_entry/screens/security_screens/security_events_list_page.dart';
import 'package:safe_entry/screens/security_screens/security_organizer_registration_page.dart';
import 'package:safe_entry/screens/security_screens/security_organizers_list_page.dart';
import 'package:safe_entry/screens/security_screens/security_scanner_page.dart';
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
    SecurityOrganizersListPage(),
    SecurityScannerPage()
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
