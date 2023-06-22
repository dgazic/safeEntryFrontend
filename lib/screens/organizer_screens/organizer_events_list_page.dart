import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/models/event_model.dart';
import 'package:safe_entry/providers/event_provider.dart';
import 'package:safe_entry/routes/routes_manager.dart';

class OrganizerEventsListPage extends StatefulWidget {
  const OrganizerEventsListPage({super.key});

  @override
  State<OrganizerEventsListPage> createState() =>
      _OrganizerEventsListPageState();
}

class _OrganizerEventsListPageState extends State<OrganizerEventsListPage> {
  EventProvider eventProvider = EventProvider();
  late Future<List<EventResponseModel>> eventsFuture;
  void initState() {
    super.initState();
    var fetchEvents = eventProvider.fetchEventsByOrganization();
    eventsFuture = fetchEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista događaja"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var events = snapshot.data!;
            return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    child: ListTile(
                      title: Text(event.Name!),
                      subtitle: Row(
                        children: [Text('Adresa: '), Text(event.Address!)],
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Map<String, dynamic> parameters = {
                          'eventId': event.Id,
                          'eventName': event.Name,
                          'eventAddress': event.Address,
                          'eventDescription': event.Description,
                          'eventStarts': event.EventStarts
                        };
                        Get.toNamed(Routes.organizerEventDetailsPage,
                            arguments: parameters);
                      },
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
