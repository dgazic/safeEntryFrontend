import 'package:flutter/material.dart';

class OrganizerWelcomePage extends StatefulWidget {
  const OrganizerWelcomePage({super.key});

  @override
  State<OrganizerWelcomePage> createState() => _OrganizerWelcomePageState();
}

class _OrganizerWelcomePageState extends State<OrganizerWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to organization administration',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
