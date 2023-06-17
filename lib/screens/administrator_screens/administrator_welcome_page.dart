import 'package:flutter/material.dart';

class AdministratorWelcomePage extends StatefulWidget {
  const AdministratorWelcomePage({super.key});

  @override
  State<AdministratorWelcomePage> createState() =>
      _AdministratorWelcomePageState();
}

class _AdministratorWelcomePageState extends State<AdministratorWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Welcome to Administration',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
