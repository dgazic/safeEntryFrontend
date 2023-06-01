import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdministratorWelcomePage extends StatefulWidget {
  const AdministratorWelcomePage({super.key});

  @override
  State<AdministratorWelcomePage> createState() =>
      _AdministratorWelcomePageState();
}

class _AdministratorWelcomePageState extends State<AdministratorWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Text("Dobrodošao!");
  }
}
