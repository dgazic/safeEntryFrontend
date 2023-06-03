import 'package:flutter/material.dart';

class SecurityWelcomePage extends StatefulWidget {
  const SecurityWelcomePage({super.key});

  @override
  State<SecurityWelcomePage> createState() => _SecurityWelcomePageState();
}

class _SecurityWelcomePageState extends State<SecurityWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to security corp. administration',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
