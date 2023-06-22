import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safe_entry/models/event_invitation_model.dart';
import 'package:safe_entry/providers/event_provider.dart';

class OrganizerEventDetailsPage extends StatefulWidget {
  const OrganizerEventDetailsPage({super.key});

  @override
  State<OrganizerEventDetailsPage> createState() =>
      _OrganizerEventDetailsPageState();
}

class _OrganizerEventDetailsPageState extends State<OrganizerEventDetailsPage> {
  late Future<List<EventInvitationResponseModel>> eventInvitationFuture;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    var fetchInvitedPeople =
        eventProvider.GetInvitedPeopleEvent(data['eventId']);
    eventProvider.fetchEventById(data['eventId']).then((value) {
      peopleInvitedCount = value.PeopleInvited;
      setState(() {});
    });
    eventInvitationFuture = fetchInvitedPeople;
  }

  var data;
  int? peopleInvitedCount;

  EventProvider eventProvider = EventProvider();
  EventInvitationResponseModel eventInvitationResponseModel =
      EventInvitationResponseModel();

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 0.2, //lesson.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Column(
      children: [
        Container(
          child: new Text(
            "Adresa: ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(7.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0)),
          child: Column(
            children: [
              new Text(
                data['eventAddress'],
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: new Text(
            "Vrijeme početka: ",
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(7.0),
          decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5.0)),
          child: new Text(
            data['eventStarts'],
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 70.0),
        Icon(
          Icons.event,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: Text(
            data['eventName'],
            style: TextStyle(color: Colors.white, fontSize: 28.0),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 3,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      // lesson.level,
                      "Broj pozvanih: ",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(
                child: Text(
              // lesson.level,
              (peopleInvitedCount != null)
                  ? peopleInvitedCount.toString()
                  : "-",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
            Expanded(flex: 5, child: coursePrice),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
                // image: new DecorationImage(
                // image: new AssetImage("drive-steering-wheel.jpg"),
                // fit: BoxFit.cover,
                // ),
                )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Row(
      children: [
        Flexible(
          child: Text(
            data['eventDescription'],
            style: TextStyle(fontSize: 18.0),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
    final invitedGuestsContent = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          icon: Icon(Icons.people),
          label: Text(
            "PREGLED POZVANIH GOSTI",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async => {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Pregled pozvanih gosti"),
                  content: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 10,
                    child: FutureBuilder(
                      future: eventInvitationFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          var invitedPeoples = snapshot.data!;
                          if (invitedPeoples.length != 0) {
                            return ListView.builder(
                              itemCount: invitedPeoples.length,
                              itemBuilder: (context, index) {
                                final invitedPeople = invitedPeoples[index];
                                return ListTile(
                                  title: Row(
                                    children: [
                                      Text(invitedPeople.firstName!),
                                      SizedBox(width: 3),
                                      Text(invitedPeople.lastName!),
                                    ],
                                  ),
                                  trailing: Icon(Icons.check),
                                  onTap: () {
                                    // Handle item selection
                                    // You can update the selected date or perform any other actions
                                  },
                                );
                              },
                            );
                          } else {
                            return Text("Nema pozvanih");
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Zatvori"),
                    ),
                  ],
                );
              },
            )
          },
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            Align(
                alignment: Alignment.bottomCenter, child: invitedGuestsContent)
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
