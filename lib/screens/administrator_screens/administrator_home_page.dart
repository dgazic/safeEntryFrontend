import 'package:flutter/material.dart';
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
    AdministratorSecurityRegistrationPage()
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
                icon: Icon(Icons.event), label: "Organizatori"),
          ]),
    );
  }
}
