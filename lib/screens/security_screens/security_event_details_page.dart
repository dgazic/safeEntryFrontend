import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:safe_entry/models/event_check_invitation.dart';
import 'package:safe_entry/providers/event_provider.dart';

class SecurityEventDetailsPage extends StatefulWidget {
  const SecurityEventDetailsPage({super.key});

  @override
  State<SecurityEventDetailsPage> createState() =>
      _SecurityEventDetailsPageState();
}

class _SecurityEventDetailsPageState extends State<SecurityEventDetailsPage> {
  var data;
  String? _data;
  int? peopleInvitedCount;
  EventProvider eventProvider = EventProvider();
  EventCheckInvitationRequestModel eventCheckInvitationRequestModel =
      EventCheckInvitationRequestModel();
  EventCheckInvitationResponseModel eventCheckInvitationResponseModel =
      EventCheckInvitationResponseModel();
  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    eventProvider.fetchEventById(data['eventId']).then((value) {
      peopleInvitedCount = value.PeopleInvited;
      setState(() {});
    });
    setState(() {});
  }

  Future<String> _scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Odustani", false, ScanMode.QR);
  }

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
        Expanded(
          child: Row(
            children: [
              Text(
                "Organizator:",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                data['companyName'],
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ],
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
            decoration: new BoxDecoration()),
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
    final scannButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton.icon(
          icon: Icon(Icons.scanner_outlined),
          label: Text(
            "PROVJERI ULAZAK",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            _data = await _scan();
            eventCheckInvitationRequestModel.invitationCode = _data;
            eventCheckInvitationRequestModel.eventId = data['eventId'];
            var dataProvider = await eventProvider.CheckInvitationCode(
                eventCheckInvitationRequestModel);
            if (dataProvider.success == true) {
              QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  title: 'OBAVIJEST',
                  confirmBtnText: 'U redu',
                  text: 'Dopušten ulaz, osoba ima validnu pozivnicu.');
            } else if (_data == "-1") {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                confirmBtnText: 'U redu',
                title: 'OBAVIJEST',
                text: 'Prekinuli ste radnju skeniranja, pokušajte ponovno',
              );
            } else {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                title: 'OBAVIJEST',
                confirmBtnText: 'U redu',
                text: 'Nije dopušten ulaz, osoba nema validnu pozivnicu.',
              );
            }
          },
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
            Align(alignment: Alignment.bottomCenter, child: scannButton)
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
