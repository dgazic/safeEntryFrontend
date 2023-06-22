import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/models/event_model.dart';
import 'package:safe_entry/providers/event_provider.dart';
import 'package:safe_entry/routes/routes_manager.dart';

class SecurityEventsListPage extends StatefulWidget {
  const SecurityEventsListPage({super.key});

  @override
  State<SecurityEventsListPage> createState() => _SecurityEventsListPageState();
}

class _SecurityEventsListPageState extends State<SecurityEventsListPage> {
  EventProvider eventProvider = EventProvider();
  late Future<List<EventResponseModel>> eventsFuture;
  void initState() {
    super.initState();
    var fetchEvents = eventProvider.fetchEvents();
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
                        children: [
                          Text('Organizator:'),
                          SizedBox(width: 8),
                          Text(event.companyName!),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Map<String, dynamic> parameters = {
                          'eventId': event.Id,
                          'eventName': event.Name,
                          'eventAddress': event.Address,
                          'eventDescription': event.Description,
                          'eventStarts': event.EventStarts,
                          'companyName': event.companyName
                        };
                        Get.toNamed(Routes.securityEventDetailsPage,
                            arguments: parameters);
                      },
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
          ;
        },
      ),
    );
  }
}
