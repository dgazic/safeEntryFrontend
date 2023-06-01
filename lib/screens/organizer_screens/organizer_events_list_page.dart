import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OrganizerEventsListPage extends StatefulWidget {
  const OrganizerEventsListPage({super.key});

  @override
  State<OrganizerEventsListPage> createState() =>
      _OrganizerEventsListPageState();
}

class _OrganizerEventsListPageState extends State<OrganizerEventsListPage> {
  @override
  Widget build(BuildContext context) {
    return Text("Lista evenata kroz kartice");
  }
}
