import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrganizerWelcomePage extends StatefulWidget {
  const OrganizerWelcomePage({super.key});

  @override
  State<OrganizerWelcomePage> createState() => _OrganizerWelcomePageState();
}

class _OrganizerWelcomePageState extends State<OrganizerWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Text("Dobrodošli");
  }
}
